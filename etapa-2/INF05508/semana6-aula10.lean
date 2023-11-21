--variable (p q r s : Prop)

/- Dedução natural -/

--(b) p ∧ (q ∧ r) ⊢ (p ∧ q) ∧ r
theorem ex_b (h1: p ∧ (q ∧ r)) : (p ∧ q) ∧ r := by
  have hp:p := And.left h1
  have hqer:q∧r := And.right h1
  have hq: q := And.left hqer
  have hr: r := And.right hqer

  apply And.intro

  apply And.intro
  exact hp
  exact hq

  exact hr

--(b) p ∧ (q ∧ r) ⊢ (p ∧ q) ∧ r
theorem ex_b2 (h1: p ∧ (q ∧ r)) : (p ∧ q) ∧ r := by
  apply And.intro

  apply And.intro
  apply h1.left
  apply h1.right.left

  apply And.right
  apply And.right
  exact h1


--(c) p ∨ (q ∧ r) ⊢ (p ∨ q) ∧ (p ∨ r)
theorem ex_c (h1: p ∨ (q ∧ r)) : (p ∨ q) ∧ (p ∨ r) := by
  have h2: p∨q := by {
    apply Or.elim h1
    --left
    intro h2_1
    apply Or.inl h2_1
    --right
    intro h2_2
    apply Or.inr
    exact h2_2.left
  }
  have h3: p∨r := by {
    apply Or.elim h1
    --left
    intro h3_1
    apply Or.inl h3_1
    --right
    intro h3_2
    apply Or.inr
    exact h3_2.right
  }
  apply And.intro
  exact h2 --p∨q
  exact h3 --p∨r

--(d) p ∧ (q  ∨ r) ⊢ (p ∧ q) ∨ (p ∧ r)
theorem ex_d (h1: p ∧ (q  ∨ r)) : (p ∧ q) ∨ (p ∧ r) := by
  have h2:p := h1.left
  apply Or.elim h1.right
  --left
  intro h3
  apply Or.inl
  apply And.intro h2 h3
  --right
  intro h4
  apply Or.inr
  apply And.intro h2 h4

--(f) ¬p ∧ ¬q ⊢ ¬(p ∨ q)
theorem ex_f (h1 : ¬p ∧ ¬q) : ¬(p ∨ q) := by
  intro h2
  apply Or.elim h2
  intro h3
  apply h1.left h3
  intro h4
  apply h1.right h4


--(h) ⊢ (p → q) → (¬p ∨ q)
theorem ex_h : (p → q) → (¬p ∨ q) := by
  sorry


-- Exercícios resolvidos pelo professor

--(a) ⊢ (p ∧ q) → (p ∨ q)
theorem ex_a : (p∧q)→(p∨q) := by
  intro h1
  apply Or.inl
  apply And.left
  exact h1

--(e) ¬(p ∨ q) ⊢ ¬p ∨ ¬q
theorem ex_e (h1 : ¬(p ∨ q)) : (¬p ∨ ¬q) := by
  apply Or.inl
  intro h2
  have h3:p∨q := Or.inl h2
  apply h1
  exact h3

--(g) ¬(p ∧ q) ⊢ ¬p ∨ ¬q
theorem ex_g (h1: ¬(p ∧ q)) : (¬p ∨ ¬q) := by
  apply Or.elim
  apply (Classical.em p)
  apply Or.elim
  apply (Classical.em q)
  intro h4
  intro h2
  apply False.elim
  apply h1
  apply And.intro
  exact h2
  exact h4
  intro h5
  intro
  apply Or.inr
  exact h5
  intro h3
  apply Or.inl
  exact h3
