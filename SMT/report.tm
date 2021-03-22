<TeXmacs|1.99.18>

<style|<tuple|generic|chinese>>

<\body>
  <doc-data|<doc-title|Project Report>|<doc-subtitle|Combinatorial Decision
  Making and Optimization (SMT)>|<doc-author|<author-data|<author-name|Hanying
  Zhang, Nour Bou-Nasr>|<\author-affiliation>
    March, 2021
  </author-affiliation>>>>

  <section|Proposed mainlines>

  <subsection|The variables and the main problem constraints>

  We first read in <em|W, H, N, Ws> and <em|Hs> respectivaly as the width of
  the whole paper, the height of the whole paper, the number of the small
  pieces, the widths of the small pieces and the heights of the small pieces.
  We then created two decision variables <em|Xs> and <em|Ys>, which represent
  the coordinates of the left-bottom corner of all the small pieces.

  <subsubsection|The small pieces should not exceed the border of the whole
  paper>

  We used <em|forall> in Minizinc to make sure that the right borders of all
  the small pieces don't exceed the right border of the whole paper, also the
  upper borders of all the small pieces don't exceed the upper border of the
  whole paper.\ 

  <subsubsection|There should be no overlap between all the small pieces>

  We used <em|forall> function to make sure that all the small pieces don't
  overlap. The hint here is that if two small pieces of paper don't overlap
  horizontally <strong|OR> vertically, then they don't overlap.\ 

  <subsubsection|The small pieces whose heights <em|Hs[i] \<gtr\> 0.5 * H>
  could only be placed horizontally>

  If the total heights of 2 small pieces are bigger than half the height of
  the whole sheet, then they could not be placed vertically, which means that
  the <math|x> coordinates are different. Thus we could use global constrint
  <em|alldifferent> upon them. More strictly, suppose their width are
  <math|w<rsub|i> and w<rsub|j> respectively,>and
  <math|w<rsub|i>\<less\>w<rsub|j>>, then the minimum distance between them
  should be <math|w<rsub|i>>.

  <subsection|Implied constraints>

  Take the vertical line for instance, the total heights of all the traversed
  pieces should not be bigger than <math|H>, and we should check all the
  vertical lines. For the CP problem we use <em|sum> and <em|forall> for
  these two requirements respectively.\ 

  <subsection|Global constraints>

  <subsubsection|Main constraints>

  Right now we didn't use any global constraints.

  <subsubsection|Implied constraints>

  \;

  <subsection|The best way of searching>

  Right now we just use the default searching technique withoud any
  optimization.

  TODO: a plot showing running times

  \;

  <subsection|Rotation>

  We need to set a new bool variable <math|O<rsub|i>> to define if piece
  <math|i> is rotated. When <math|O<rsub|i>> is true, the width and height of
  piece <math|i> is exchanged. <code|>

  TODO: which one of CP and SMT are easier to implement rotation?

  <subsection|Multiple pieces of the same dimension>

  If there are multiple pieces with the same dimension, they should be placed
  together with each other to form a bigger piece. The problem would be
  easier as the number of small pieces are smaller and we are just forming
  new rectangles. But we should also consider that they couldn't exceed the
  borders of the whole sheet of paper, also if they can't perfectly fit the
  width or length of the whole papaer, we should consider leaving enough
  space for other small rectangels. We should also consider the direction
  they grow, for example, two pieces of size 3x4, they could form a bigger
  piece with size 6x4 or 3x8.

  <section|Other remarks>

  We wrote a python script file named result_check.py for checkig whether the
  result we got is right.

  This file is run in terminal and would give a colored representation of the
  whole sheet. One of the result picture is as follows:

  \;

  There's still a problem with this script file which is that some adjacent
  rectangles are with the same color, as we use only 7 different colors(maybe
  we should use CP again to solve this problem :p).\ 

  \;

  \;

  \;
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|1.4|2>>
    <associate|auto-11|<tuple|1.5|2>>
    <associate|auto-12|<tuple|1.6|2>>
    <associate|auto-13|<tuple|2|2>>
    <associate|auto-2|<tuple|1.1|1>>
    <associate|auto-3|<tuple|1.1.1|1>>
    <associate|auto-4|<tuple|1.1.2|1>>
    <associate|auto-5|<tuple|1.1.3|1>>
    <associate|auto-6|<tuple|1.2|1>>
    <associate|auto-7|<tuple|1.3|1>>
    <associate|auto-8|<tuple|1.3.1|1>>
    <associate|auto-9|<tuple|1.3.2|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Proposed
      mainlines> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>The variables and the main
      problem constraints <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|2tab>|1.1.1<space|2spc>The small pieces should
      not exceed the border of the whole paper
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|2tab>|1.1.2<space|2spc>There should be no overlap
      between all the small pieces <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|2tab>|1.1.3<space|2spc>The small pieces whose
      heights <with|font-shape|<quote|italic>|Hs[i] \<gtr\> 0.5 * H> could
      only be placed horizontally <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>Implied constraints
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|1tab>|1.3<space|2spc>Global constraints
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|2tab>|1.3.1<space|2spc>Main constraints
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <with|par-left|<quote|2tab>|1.3.2<space|2spc>Implied constraints
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>>

      <with|par-left|<quote|1tab>|1.4<space|2spc>The best way of searching
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|1.5<space|2spc>Rotation
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|1.6<space|2spc>Multiple pieces of the same
      dimension <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Other
      remarks> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>