library(shinydashboard)
library(shiny)
library(shinythemes)
dashboardPage(skin="blue",
              
              #tags$head(
              # tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
              #),
              #tabsetPanel(
              #tabPanel("CGRS Calculator",
              dashboardHeader(title="CGRS Calculator",titleWidth=250),
              
              
              dashboardSidebar(width=250,
                               sidebarMenu(
                                 menuItem("Home Page",icon=icon("home"),tabName="home"),
                                 menuItem("CGRS Calculator",icon=icon("calculator"),tabName="Calculator"),
                                 
                                 tags$head(tags$style(HTML('
                                                           .main-header .logo {
                                                           font-family: "Georgia", Times, "Times New Roman", serif;
                                                           font-weight: bold;
                                                           font-size: 24px;
                                                           }
                                                           ')))
                                 
                                 )
                                 ),
              
              dashboardBody(
                tabItems(
                  tabItem(tabName="home",
                          h2(  style = "font-family: 'Helvetica'; font-size:16pt; font-weight: bold;text-align:center" ,
                               "Calculate risk score for individual gastrc cancer patients using CGRS",tags$p("")),
                          img( src="model.png",height = 600,style = "display: block; margin-left: auto; margin-right: auto", tags$p("")),
                          tags$br()),
                  
                  
                  tabItem(tabName="Calculator",
                          fluidRow(
                            tabBox(width=12,
                                   tabPanel("INPUT",h4(style = "font-size:12pt;text-align:left; line-height:13pt;font-weight: bold",
                                                             "Please input the expression of corresponding genes, 
                                                              AJCC Stage, and age of individual GC patients.
                                                              Then click Refresh & Calculate to get the results.",
                                                              tags$p("")),
                                                            h5(style = "font-size:10pt; text-align:left; line-height:13pt;font-color: 'gray'",
                                                              "Note: for Affymetrix Microarray and Illumina Microarray data,the expression level should log2 scale. For RNASeq data, the 
                                                               expression level should be log2 (RSEM + 1) scale. For qRT-PCR data, the expression level should be normalized with reference
                                                               gene. The AJCC Stage should be 1, 2, 3, and 4. The age should be years."),
                                            br(),
                                            splitLayout(selectInput("DataType", "Choose a datatype:",
                                                        choices = list("Affymetrix Microarray" = 1,
                                                                       "Illumina Microarray" = 2, 
                                                                       "RNASeq" = 3,
                                                                       "qRT-PCR" = 4),selected = 1),
                                            numericInput("Stage", "The AJCC stage for GC patient:",""),
                                            numericInput("Age", "The age for GC patient:","")),
                                            # Input: input the expression of nine genes
                                            splitLayout(numericInput("APOD","The expression level of APOD:",""),
                                            numericInput("CCDC92","The expression level of CCDC92:",""),
                                            numericInput("CYS1","The expression level of CYS1:","")),
                                            splitLayout(numericInput("GSDME","The expression level of GSDME:",""),
                                            numericInput("ST8SIA5","The expression level of ST8SIA5:",""),
                                            numericInput("STARD3NL","The expression level of STARD3NL:","")),
                                            splitLayout(numericInput("TMEM245","The expression level of TMEM245:",""),
                                            numericInput("TSPYL5","The expression level of TSPYL5:",""),
                                            numericInput("VAT1","The expression level of VAT1:","")),
                                            actionButton("action_Calc", label = "Refresh & Calculate")),
                                   
                                   
                                   tabPanel("CHECK",
                                            h3("Please check the parameters you input"),
                                            width=12, 
                                            tags$style(type='text/css', '#text_type {background-color: white; 
                                              color: purple; height: 35px; overflow: visible; text-align:left; padding: 8px}'),
                                            verbatimTextOutput("text_type"),
                                            tags$style(type='text/css', '#text_APOD {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),
                                            verbatimTextOutput("text_APOD"),
                                            tags$style(type='text/css', '#text_CCDC92 {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),
                                            verbatimTextOutput("text_CCDC92"),                                            
                                            tags$style(type='text/css', '#text_CYS1 {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),
                                            verbatimTextOutput("text_CYS1"),                                            
                                            tags$style(type='text/css', '#text_GSDME {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),
                                            verbatimTextOutput("text_GSDME"),                                            
                                            tags$style(type='text/css', '#text_ST8SIA5 {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),
                                            verbatimTextOutput("text_ST8SIA5"),                                            
                                            tags$style(type='text/css', '#text_STARD3NL {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),                                            
                                            verbatimTextOutput("text_STARD3NL"),
                                            tags$style(type='text/css', '#text_TMEM245 {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),                                                                                        
                                            verbatimTextOutput("text_TMEM245"),
                                            tags$style(type='text/css', '#text_TSPYL5 {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),                                            
                                            verbatimTextOutput("text_TSPYL5"),
                                            tags$style(type='text/css', '#text_VAT1 {background-color: white; 
                                              color: green; height: 35px; overflow: visible; text-align:left; padding: 8px}'),                                            
                                            verbatimTextOutput("text_VAT1"),
                                            tags$style(type='text/css', '#text_stage {background-color: white; 
                                              color: blue; height: 35px; overflow: visible; text-align:left; padding: 8px}'),                                            
                                            verbatimTextOutput("text_stage"),
                                            tags$style(type='text/css', '#text_age {background-color: white; 
                                              color: blue; height: 35px; overflow: visible; text-align:left; padding: 8px}'),                                            
                                            verbatimTextOutput("text_age")),
                                   
                                   tabPanel("RESULT",
                                            h3("Calculated results:"),
                                            h4(style = "color:black",textOutput("text_GRS")),
                                            h4(style = "color:black",textOutput("text_CRS")),
                                            h4(style = "color:black",textOutput("text_CGRS")),
                                            h4(style = "color:black",textOutput("text_1year")),
                                            h4(style = "color:black",textOutput("text_3year")),
                                            h4(style = "color:black",textOutput("text_5year")),width=12),
                                   
                                   tabPanel("INSTRUCTION",
                                           p(h4("CGRS Calculator:")),
                                           helpText("This application calculates GRS, CRS, and CGRS for individual GC patients."),
                                           HTML("<u><b>Equation for calculation: </b></u>
                                                <br>
                                                <b>GRS = 0.010 * <I>APOD</I> + 0.264 * <I>CCDC92</I> +
                                                0.176 * <I>CYS1</I> + 0.262 * <I>GSDME</I> - 0.308 * <I>ST8SIA5</I> + 
                                                0.412 * <I>STARD3NL</I> + 0.028 * <I>TMEM245</I> + 0.189 * <I>TSPYL5</I> + 
                                                0.249 * <I>CYS1</I></b>
                                                <br>
                                                <b> CRS = 0.021 * Age (years) + stage; stage I = 0, stage II = 0.31, 
                                                stage III = 0.75, stage IV = 1.56</b>
                                                <br>
                                                <b> CGRS = 1.25 * CRS + 0.88 * GRS</b>
                                                <br>
                                                where: <br>
                                                GRS = Gentic risk score, <u>based on ACRG traning set.</u><br>
                                                CRS = Clinic risk score, <u>based on SEER cohort.</u><br>
                                                CGRS = Clinic and genetic risk score, <u>based on ACRG traning set.</u><br>
                                                "),
                                                h4(
                                                  tags$p(""),
                                                  tags$a(href="https://github.com/sunqiangzai", "Source code : Github"),
                                                  tags$p(""),
                                                  tags$a(href="mailto:sunqiangzai@126.com", 
                                                         "Please contact Sunq Qiang, if there are any questions about CGRS."),
                                                  ""),width=12)
                                   )
                          )
                  )
                          )
                )
              )

