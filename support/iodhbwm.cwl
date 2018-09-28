# << default packages >>
#include:babel
#include:biblatex
#include:booktabs
#include:caption
#include:cleveref
#include:csquotes
#include:geometry
#include:graphicx
#include:hyperref
#include:listings
#include:mathtools
#include:scrlayer-scrpage
#include:siunitx
#include:tabularx
#include:tcolorbox

# << debug option enabled >>
#ifOption:debug
#include:blindtext
#include:lipsum
#endif

# << custom packages >>
#ifOption:load-dhbw-templates
#include:iodhbwm-templates
#endif