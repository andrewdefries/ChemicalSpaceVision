################################################################################################
library(shiny)
library(hexbin)
################################################################################################

widget_style <-
  "display: inline-block;
  vertical-align: text-top;
  padding: 7px;
  border: solid;
  border-width: 1px;
  border-radius: 4px;
  border-color: #CCC;"
#################################################################################
shinyUI(bootstrapPage(
headerPanel("ChemicalSpace::MicrosourceSpectrum.sdf"),
  wellPanel(
    div(style = widget_style,
	sliderInput("obs", "Size of hexbin",min=1, max=100, value=10)),
    div(style = widget_style,
	sliderInput("clid","Cluster ID",min=1, max=130, value=18)),
    div(style = widget_style,
	sliderInput("cmp_view","Query Compound", min=1, max=2000, value=1)),
    div(style = widget_style,
	textInput("CutOff", "Tanimoto Cutoff (0.1-0.99):", '0.2')),
    div(style = widget_style,
	textInput("QueryB", "Compare to Query by ID", 'CMP101')),
    #div(style = widget_style,
	#textInput("QueryB", "Compare to Query by smiles", 'CCC')),	
    div(style = widget_style,
	sliderInput("hits", "Hits number to include:", min=1, max=100, value=9))

),
#################################################################################
tabsetPanel(
   tabPanel("Hexbin plot", plotOutput("main_plot")), 
   tabPanel("Coord table", tableOutput("coord_table")),
   tabPanel("MDS", plotOutput("MDS_plot")),
   tabPanel("Sunflower Plot", plotOutput("sunflower_plot")),
   tabPanel("Query Tanimoto score", verbatimTextOutput("summary")),
   tabPanel("Hclust", plotOutput("hclust_plot"),height="1000px"),
   tabPanel("Query Compound Structure", plotOutput("compound_matrix")),
   tabPanel("hclust structures", plotOutput("compound_matrixB"))
##################################################################################################
  )
))


