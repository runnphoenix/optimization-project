<TeXmacs|1.99.18>

<style|<tuple|generic|chinese>>

<\body>
  <doc-data|<doc-title|Project Report >|<doc-subtitle|Combinatorial Decision
  Making and Optimization>|<doc-author|<author-data|<author-name|Hanying
  Zhang, Nour Bou-Nasr>|<\author-affiliation>
    March, 2021
  </author-affiliation>>>>

  <section|Proposed mainlines>

  <subsection|The variables and the main problem constraints>

  We first read in W, H, N, Ws and Hs respectivaly as the width of the
  original paper, the height of the original paper, the number of the small
  pieces, the width of the small pieces and the height of the small pieces.
  We then created two decision variables Xs and Ys, which represent the
  coordinates of the left-bottom corner of all the small pieces.

  <subsubsection|The small pieces should not exceed the size of the original
  paper>

  We used <em|forall> in Minizinc to make sure that the right side of all the
  small pieces don't exceed the right side of the original paper, also the
  upper size of all the small pieces don't exceed the upper size of the
  original paper.\ 

  <subsubsection|There should be no overlap between all the small pieces>

  We used forall function to make sure that all the small pieces don't
  overlap. The hint here is that if two small pieces of paper don't overlap
  horizontally <strong|OR> vertically, then they don't overlap.\ 

  We also used <em|assert> to make sure that the total size of all the small
  pieces are not bigger than the size of the original paper.

  <subsection|Implied constraints>

  Take the vertical line for instance, the total height of all the traversed
  pieces should not be bigger than <math|l>, and we should check all the
  vertical lines. For the CP problem we use <em|sum> and <em|forall> for
  these two requirements respectively. For the SMT problem, we
  TODO<text-dots>

  <subsection|Global constraints>

  <subsubsection|Main constraints>

  We used <em|diffn> in Minizinc to make sure all small pieces don't overlap.

  <subsubsection|Implied constraints>

  For the global implied constrants, we use <em|cumulative> constraint in
  Minizinc. This contraint is originally used for scheduling problems, but
  it's suitable here. Specifically, we take the left coner coordinate of a
  small piece as the starting time of a task, the width or height as the
  duration of the task, the height or width as the resource requirement, and
  <math|w> or <math|l> as the capacity.

  <subsection|The best way of searching>

  We tried several combinations of searching techniques. For variable
  selection, we tried <em|dom_w_deg> and <em|first_fail>, for domain
  selection we tried <em|indomain_min> and <em|indomin_random>. We also tried
  restart. The most rubain combination we found is <em|dom_w_deg> and
  <em|indomain_random> with <em|luby restart>. TODO: result analysis.

  <subsection|Rotation>

  We need to set a new bool variable <math|O<rsub|i>> to define if piece
  <math|i> is rotated. When <math|O<rsub|i>> is true, the width and height of
  piece <math|i> is exchanged. <code|>

  <subsection|Multiple pieces of the same dimension>

  If there are multiple pieces with the same dimension, they should be placed
  adjcent with each other to form a bigger piece. TODO: the reason<text-dots>

  <section|Other Details>

  We also tried symmetry breaking<text-dots>

  For reading and writing to files<text-dots>
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-10|<tuple|1.5|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-11|<tuple|1.6|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-12|<tuple|2|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-2|<tuple|1.1|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-3|<tuple|1.1.1|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-4|<tuple|1.1.2|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-5|<tuple|1.2|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-6|<tuple|1.3|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-7|<tuple|1.3.1|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-8|<tuple|1.3.2|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
    <associate|auto-9|<tuple|1.4|?|../../.TeXmacs/texts/scratch/no_name_1.tm>>
  </collection>
</references>