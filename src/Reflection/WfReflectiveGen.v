(** * A reflective version of [Wf]/[WfRel] proofs *)
(** Because every constructor of [Syntax.wff] stores the syntax tree
    being proven well-formed, a proof that a syntax tree is
    well-formed is quadratic in the size of the syntax tree.  (Tacking
    an extra term on to the head of the syntax tree requires an extra
    constructor of [Syntax.wff], and that constructor stores the
    entirety of the new syntax tree.)

    In practice, this makes proving well-formedness of large trees
    very slow.  To remedy this, we provide an alternative type
    ([reflect_wffT]) that implies [Syntax.wff], but is only linear in
    the size of the syntax tree, with a coefficient less than 1.

    The idea is that, since we already know the syntax-tree arguments
    to the constructors (and, moreover, already fully know the shape
    of the [Syntax.wff] proof, because it will exactly match the shape
    of the syntax tree), the proof doesn't have to store any of that
    information.  It only has to store the genuinely new information
    in [Syntax.wff], namely, that the constants don't depend on the
    [var] argument (i.e., that the constants in the same location in
    the two expressions are equal), and that there are no free nor
    mismatched variables (i.e., that the variables in the same
    location in the two expressions are in the relevant list of
    binders).  We can make the further optimization of storing the
    location in the list of each binder, so that all that's left to
    verify is that the locations line up correctly.

    Since there is no way to assign list locations (De Bruijn indices)
    after the fact (that is, once we have an [exprf var t] rather than
    an [Expr t]), we instead start from an expression where [var] is
    enriched with De Bruijn indices, and talk about [Syntax.wff] of
    that expression stripped of its De Bruijn indices.  Since this
    procedure is only expected to work on concrete syntax trees, we
    will be able to simply check by unification to check that
    stripping the indices results in the term that we started with.

    The interface of this file is that, to prove a [Syntax.Wf] goal,
    you invoke the tactic [reflect_Wf base_type_eq_semidec_is_dec
    op_beq_bl], where:

    - [base_type_eq_semidec_is_dec : forall t1 t2,
       base_type_eq_semidec_transparent t1 t2 = None -> t1 <> t2] for
       some [base_type_eq_semidec_transparent : forall t1 t2 :
       base_type_code, option (t1 = t2)], and

    - [op_beq_bl : forall t1 tR x y, prop_of_option (op_beq t1 tR x y)
      -> x = y] for some [op_beq : forall t1 tR, op t1 tR -> op t1 tR
      -> option pointed_Prop] *)

Require Import Coq.Arith.Arith Coq.Logic.Eqdep_dec.
Require Import Crypto.Reflection.Syntax.
Require Import Crypto.Util.Notations Crypto.Util.Tactics Crypto.Util.Option Crypto.Util.Sigma Crypto.Util.Prod Crypto.Util.Decidable Crypto.Util.ListUtil.
Require Export Crypto.Util.PointedProp. (* export for the [bool >-> option pointed_Prop] coercion *)
Require Export Crypto.Util.FixCoqMistakes.


Section language.
  (** To be able to optimize away so much of the [Syntax.wff] proof,
      we must be able to decide a few things: equality of base types,
      and equality of operator codes.  Since we will be casting across
      the equality proofs of base types, we require that this
      semi-decider give transparent proofs.  (This requirement is not
      enforced, but it will block [vm_compute] when trying to use the
      lemma in this file.) *)
  Context (base_type_code : Type)
          (interp_base_type1 interp_base_type2 : base_type_code -> Type)
          (base_type_eq_semidec_transparent : forall t1 t2 : base_type_code, option (t1 = t2))
          (base_type_eq_semidec_is_dec : forall t1 t2, base_type_eq_semidec_transparent t1 t2 = None -> t1 <> t2)
          (op : flat_type base_type_code -> flat_type base_type_code -> Type)
          (R : forall t, interp_base_type1 t -> interp_base_type2 t -> Prop).
  (** In practice, semi-deciding equality of operators should either
      return [Some trivial] or [None], and not make use of the
      generality of [pointed_Prop].  However, we need to use
      [pointed_Prop] internally because we need to talk about equality
      of things of type [var t], for [var : base_type_code -> Type].
      It does not hurt to allow extra generality in [op_beq]. *)
  Context (op_beq : forall t1 tR, op t1 tR -> op t1 tR -> option pointed_Prop).
  Context (op_beq_bl : forall t1 tR x y, prop_of_option (op_beq t1 tR x y) -> x = y).
  Context {var1 var2 : base_type_code -> Type}.

  Local Notation eP := (fun t => var1 (fst t) * var2 (snd t))%type (only parsing).

  (* convenience notations that fill in some arguments used across the section *)
  Local Notation flat_type := (flat_type base_type_code).
  Local Notation type := (type base_type_code).
  Let Tbase := @Tbase base_type_code.
  Local Coercion Tbase : base_type_code >-> Syntax.flat_type.
  Local Notation interp_type1 := (interp_type interp_base_type1).
  Local Notation interp_type2 := (interp_type interp_base_type2).
  Local Notation interp_flat_type1 := (interp_flat_type_gen interp_base_type1).
  Local Notation interp_flat_type2 := (interp_flat_type_gen interp_base_type2).
  Local Notation exprf1 := (@exprf base_type_code interp_base_type1 op).
  Local Notation exprf2 := (@exprf base_type_code interp_base_type2 op).
  Local Notation expr1 := (@expr base_type_code interp_base_type1 op).
  Local Notation expr2 := (@expr base_type_code interp_base_type2 op).

  Local Ltac inversion_base_type_code_step :=
    match goal with
    | [ H : ?x = ?x :> base_type_code |- _ ]
      => assert (H = eq_refl) by eapply UIP_dec, dec_rel_of_semidec_rel, base_type_eq_semidec_is_dec; subst H
    | [ H : ?x = ?y :> base_type_code |- _ ] => subst x || subst y
    end.
  Local Ltac inversion_base_type_code := repeat inversion_base_type_code_step.

  (* lift [base_type_eq_semidec_transparent] across [flat_type] *)
  Fixpoint flat_type_eq_semidec_transparent (t1 t2 : flat_type) : option (t1 = t2)
    := match t1, t2 return option (t1 = t2) with
       | Syntax.Tbase t1, Syntax.Tbase t2
         => option_map (@f_equal _ _ Tbase _ _)
                      (base_type_eq_semidec_transparent t1 t2)
       | Syntax.Tbase _, _ => None
       | Prod A B, Prod A' B'
         => match flat_type_eq_semidec_transparent A A', flat_type_eq_semidec_transparent B B' with
           | Some p, Some q => Some (f_equal2 Prod p q)
           | _, _ => None
           end
       | Prod _ _, _ => None
       end.
  Fixpoint type_eq_semidec_transparent (t1 t2 : type) : option (t1 = t2)
    := match t1, t2 return option (t1 = t2) with
       | Syntax.Tflat t1, Syntax.Tflat t2
         => option_map (@f_equal _ _ (@Tflat _) _ _)
                      (flat_type_eq_semidec_transparent t1 t2)
       | Syntax.Tflat _, _ => None
       | Arrow A B, Arrow A' B'
         => match base_type_eq_semidec_transparent A A', type_eq_semidec_transparent B B' with
           | Some p, Some q => Some (f_equal2 (@Arrow base_type_code) p q)
           | _, _ => None
           end
       | Arrow _ _, _ => None
       end.
  Lemma base_type_eq_semidec_transparent_refl t : base_type_eq_semidec_transparent t t = Some eq_refl.
  Proof.
    clear -base_type_eq_semidec_is_dec.
    pose proof (base_type_eq_semidec_is_dec t t).
    destruct (base_type_eq_semidec_transparent t t); intros; try intuition congruence.
    inversion_base_type_code; reflexivity.
  Qed.
  Lemma flat_type_eq_semidec_transparent_refl t : flat_type_eq_semidec_transparent t t = Some eq_refl.
  Proof.
    clear -base_type_eq_semidec_is_dec.
    induction t as [t | A B IHt]; simpl.
    { rewrite base_type_eq_semidec_transparent_refl; reflexivity. }
    { rewrite_hyp !*; reflexivity. }
  Qed.
  Lemma type_eq_semidec_transparent_refl t : type_eq_semidec_transparent t t = Some eq_refl.
  Proof.
    clear -base_type_eq_semidec_is_dec.
    induction t as [t | A B IHt]; simpl.
    { rewrite flat_type_eq_semidec_transparent_refl; reflexivity. }
    { rewrite base_type_eq_semidec_transparent_refl; rewrite_hyp !*; reflexivity. }
  Qed.

  Definition op_beq' t1 tR t1' tR' (x : op t1 tR) (y : op t1' tR') : option pointed_Prop
    := match flat_type_eq_semidec_transparent t1 t1', flat_type_eq_semidec_transparent tR tR' with
       | Some p, Some q
         => match p in (_ = t1'), q in (_ = tR') return op t1' tR' -> _ with
           | eq_refl, eq_refl => fun y => op_beq _ _ x y
           end y
       | _, _ => None
       end.

  (** While [Syntax.wff] is parameterized over a list of [sigT (fun t
      => var1 t * var2 t)], it is simpler here to make everything
      heterogenous, rather than trying to mix homogenous and
      heterogenous things.† Thus we parameterize our [reflect_wffT]
      over a list of [sigT (fun t => var1 (fst t) * var2 (snd t))],
      and write a function ([duplicate_type]) that turns the former
      into the latter.

      † This is an instance of the general theme that abstraction
        barriers are important.  Here we enforce the abstraction
        barrier that our input decision procedures are homogenous, but
        all of our internal code is strictly heterogenous.  This
        allows us to contain the conversions between homogenous and
        heterogenous code to a few functions: [op_beq'],
        [eq_type_and_var], [eq_type_and_const], and to the statement
        about [Syntax.wff] itself.  *)

  Definition eq_semidec_and_gen {T} (semidec : forall x y : T, option (x = y))
             (t t' : T) (f g : T -> Type) (R : forall t, f t -> g t -> Prop)
             (x : f t) (x' : g t')
    : option pointed_Prop
    := match semidec t t' with
       | Some p
         => Some (inject (R _ (eq_rect _ f x _ p) x'))
       | None => None
       end.

  (* Here is where we use the generality of [pointed_Prop], to say
     that two things of type [var1] are equal, and two things of type
     [var2] are equal. *)
  Definition eq_type_and_var : sigT eP -> sigT eP -> option pointed_Prop
    := fun x y => (eq_semidec_and_gen
                  base_type_eq_semidec_transparent _ _ var1 var1 (fun _ => eq) (fst (projT2 x)) (fst (projT2 y))
                /\ eq_semidec_and_gen
                     base_type_eq_semidec_transparent _ _ var2 var2 (fun _ => eq) (snd (projT2 x)) (snd (projT2 y)))%option_pointed_prop.
  Definition rel_type_and_const (t t' : flat_type) (x : interp_flat_type1 t) (y : interp_flat_type2 t')
    : option pointed_Prop
    := eq_semidec_and_gen
         flat_type_eq_semidec_transparent _ _ interp_flat_type1 interp_flat_type2 (fun t => interp_flat_type_gen_rel_pointwise2 R) x y.

  Definition duplicate_type (ls : list (sigT (fun t => var1 t * var2 t)%type)) : list (sigT eP)
    := List.map (fun v => existT eP (projT1 v, projT1 v) (projT2 v)) ls.

  Lemma duplicate_type_app ls ls'
    : (duplicate_type (ls ++ ls') = duplicate_type ls ++ duplicate_type ls')%list.
  Proof. apply List.map_app. Qed.
  Lemma duplicate_type_length ls
    : List.length (duplicate_type ls) = List.length ls.
  Proof. apply List.map_length. Qed.
  Lemma duplicate_type_in t v ls
    : List.In (existT _ (t, t) v) (duplicate_type ls) -> List.In (existT _ t v) ls.
  Proof.
    unfold duplicate_type; rewrite List.in_map_iff.
    intros [ [? ?] [? ?] ].
    inversion_sigma; inversion_prod; inversion_base_type_code; subst; simpl.
    assumption.
  Qed.
  Lemma duplicate_type_not_in G t t0 v (H : base_type_eq_semidec_transparent t t0 = None)
    : ~List.In (existT _ (t, t0) v) (duplicate_type G).
  Proof.
    apply base_type_eq_semidec_is_dec in H.
    clear -H; intro H'.
    induction G as [|? ? IHG]; simpl in *; destruct H';
      intuition; congruence.
  Qed.

  Definition preflatten_binding_list2 t1 t2 : option (forall (x : interp_flat_type_gen var1 t1) (y : interp_flat_type_gen var2 t2), list (sigT (fun t => var1 t * var2 t)%type))
    := match flat_type_eq_semidec_transparent t1 t2 with
       | Some p
         => Some (fun x y
                 => let x := eq_rect _ (interp_flat_type_gen var1) x _ p in
                   flatten_binding_list base_type_code x y)
       | None => None
       end.
  Definition flatten_binding_list2 t1 t2 : option (forall (x : interp_flat_type_gen var1 t1) (y : interp_flat_type_gen var2 t2), list (sigT eP))
    := option_map (fun f x y => duplicate_type (f x y)) (preflatten_binding_list2 t1 t2).
  (** This function adds De Bruijn indices to variables *)
  Fixpoint natize_interp_flat_type_gen var t (base : nat) (v : interp_flat_type_gen var t) {struct t}
    : nat * interp_flat_type_gen (fun t : base_type_code => nat * var t)%type t
    := match t return interp_flat_type_gen var t -> nat * interp_flat_type_gen _ t with
       | Prod A B => fun v => let ret := @natize_interp_flat_type_gen _ A base (fst v) in
                          let base := fst ret in
                          let a := snd ret in
                          let ret := @natize_interp_flat_type_gen _ B base (snd v) in
                          let base := fst ret in
                          let b := snd ret in
                          (base, (a, b))
       | Syntax.Tbase t => fun v => (S base, (base, v))
       end v.
  Arguments natize_interp_flat_type_gen {var t} _ _.
  Lemma length_natize_interp_flat_type_gen1 {t} (base : nat) (v1 : interp_flat_type_gen var1 t) (v2 : interp_flat_type_gen var2 t)
    : fst (natize_interp_flat_type_gen base v1) = length (flatten_binding_list base_type_code v1 v2) + base.
  Proof.
    revert base; induction t; simpl; [ reflexivity | ].
    intros; rewrite List.app_length, <- plus_assoc.
    rewrite_hyp <- ?*; reflexivity.
  Qed.
  Lemma length_natize_interp_flat_type_gen2 {t} (base : nat) (v1 : interp_flat_type_gen var1 t) (v2 : interp_flat_type_gen var2 t)
    : fst (natize_interp_flat_type_gen base v2) = length (flatten_binding_list base_type_code v1 v2) + base.
  Proof.
    revert base; induction t; simpl; [ reflexivity | ].
    intros; rewrite List.app_length, <- plus_assoc.
    rewrite_hyp <- ?*; reflexivity.
  Qed.

  (* This function strips De Bruijn indices from expressions *)
  Fixpoint unnatize_exprf {interp_base_type var t} (base : nat)
           (e : @Syntax.exprf base_type_code interp_base_type op (fun t => nat * var t)%type t)
    : @Syntax.exprf base_type_code interp_base_type op var t
    := match e in @Syntax.exprf _ _ _ _ t return Syntax.exprf _ _ _ t with
       | Const _ x => Const x
       | Var _ x => Var (snd x)
       | Op _ _ op args => Op op (@unnatize_exprf _ _ _ base args)
       | LetIn _ ex _ eC => LetIn (@unnatize_exprf _ _ _ base ex)
                             (fun x => let v := natize_interp_flat_type_gen base x in
                                    @unnatize_exprf _ _ _ (fst v) (eC (snd v)))
       | Pair _ x _ y => Pair (@unnatize_exprf _ _ _ base x) (@unnatize_exprf _ _ _ base y)
       end.
  Fixpoint unnatize_expr {interp_base_type var t} (base : nat)
           (e : @Syntax.expr base_type_code interp_base_type op (fun t => nat * var t)%type t)
    : @Syntax.expr base_type_code interp_base_type op var t
    := match e in @Syntax.expr _ _ _ _ t return Syntax.expr _ _ _ t with
       | Return _ x => unnatize_exprf base x
       | Abs tx tR f => Abs (fun x : var tx => let v := natize_interp_flat_type_gen (t:=tx) base x in
                                           @unnatize_expr _ _ _ (fst v) (f (snd v)))
       end.

  Fixpoint reflect_wffT (G : list (sigT (fun t => var1 (fst t) * var2 (snd t))%type))
           {t1 t2 : flat_type}
           (e1 : @exprf1 (fun t => nat * var1 t)%type t1)
           (e2 : @exprf2 (fun t => nat * var2 t)%type t2)
           {struct e1}
    : option pointed_Prop
    := match e1, e2 return option _ with
       | Const t0 x, Const t1 y
         => match flat_type_eq_semidec_transparent t0 t1 with
           | Some p => Some (inject (interp_flat_type_gen_rel_pointwise2 R (eq_rect _ interp_flat_type1 x _ p) y))
           | None => None
           end
       | Const _ _, _ => None
       | Var t0 x, Var t1 y
         => match beq_nat (fst x) (fst y), List.nth_error G (List.length G - S (fst x)) with
           | true, Some v => eq_type_and_var v (existT _ (t0, t1) (snd x, snd y))
           | _, _ => None
           end
       | Var _ _, _ => None
       | Op t1 tR op args, Op t1' tR' op' args'
         => match @reflect_wffT G t1 t1' args args', op_beq' t1 tR t1' tR' op op' with
           | Some p, Some q => Some (p /\ q)%pointed_prop
           | _, _ => None
           end
       | Op _ _ _ _, _ => None
       | LetIn tx ex tC eC, LetIn tx' ex' tC' eC'
         => match @reflect_wffT G tx tx' ex ex', @flatten_binding_list2 tx tx', flat_type_eq_semidec_transparent tC tC' with
           | Some p, Some G0, Some _
             => Some (p /\ inject (forall (x : interp_flat_type_gen var1 tx) (x' : interp_flat_type_gen var2 tx'),
                                    match @reflect_wffT (G0 x x' ++ G)%list _ _
                                                       (eC (snd (natize_interp_flat_type_gen (List.length G) x)))
                                                       (eC' (snd (natize_interp_flat_type_gen (List.length G) x'))) with
                                    | Some p => to_prop p
                                    | None => False
                                    end))
           | _, _, _ => None
           end
       | LetIn _ _ _ _, _ => None
       | Pair tx ex ty ey, Pair tx' ex' ty' ey'
         => match @reflect_wffT G tx tx' ex ex', @reflect_wffT G ty ty' ey ey' with
           | Some p, Some q => Some (p /\ q)
           | _, _ => None
           end
       | Pair _ _ _ _, _ => None
       end%pointed_prop.

    Fixpoint reflect_wfT (G : list (sigT (fun t => var1 (fst t) * var2 (snd t))%type))
           {t1 t2 : type}
           (e1 : @expr1 (fun t => nat * var1 t)%type t1)
           (e2 : @expr2 (fun t => nat * var2 t)%type t2)
           {struct e1}
    : option pointed_Prop
    := match e1, e2 return option _ with
       | Return _ x, Return _ y
         => reflect_wffT G x y
       | Return _ _, _ => None
       | Abs tx tR f, Abs tx' tR' f'
         => match @flatten_binding_list2 tx tx', type_eq_semidec_transparent tR tR' with
           | Some G0, Some _
             => Some (inject (forall (x : interp_flat_type_gen var1 tx) (x' : interp_flat_type_gen var2 tx'),
                                match @reflect_wfT (G0 x x' ++ G)%list _ _
                                                   (f (snd (natize_interp_flat_type_gen (List.length G) x)))
                                                   (f' (snd (natize_interp_flat_type_gen (List.length G) x'))) with
                                | Some p => to_prop p
                                | None => False
                                end))
           | _, _ => None
           end
       | Abs _ _ _, _ => None
       end%pointed_prop.
End language.
