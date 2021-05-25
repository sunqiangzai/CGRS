## This is how to get your code to github !!

# libraries we need
library(shiny)
library(car)

# Create the graph
shinyServer(function(input, output) {
  oney = read.table("1-year Survival Probability.txt",header = T,sep = "\t",
                    row.names = 1,stringsAsFactors = F)
  oney = oney[order(oney[,1]),]
  
  ProbalilityOne <- function(x) {
    temp = rank(c(x,oney[,1]))
    #res_upper = sprintf("%1.2f%%",(oney[temp[1]-1,2])*100)
    #res_lower = sprintf("%1.2f%%",(oney[temp[1],2])*100)
    res_pre =  sprintf("%1.2f%%",((oney[temp[1]-1,2] + oney[temp[1],2])/2)*100)
    #res_prob = paste(res_pre," (",
    #                res_lower," - ",
    #                res_upper,")",sep = "")
    return(res_pre)
  }
  
  threey = read.table("3-year Survival Probability.txt",header = T,sep = "\t",
                      row.names = 1,stringsAsFactors = F)
  threey = threey[order(threey[,1]),]
  
  ProbalilityThree <- function(x) {
    temp = rank(c(x,threey[,1]))
    #res_upper = sprintf("%1.2f%%",(threey[temp[1]-1,2])*100)
    #res_lower = sprintf("%1.2f%%",(threey[temp[1],2])*100)
    res_pre =  sprintf("%1.2f%%",((threey[temp[1]-1,2] + threey[temp[1],2])/2)*100)
    #res_prob = paste(res_pre," (",
    #                 res_lower," - ",
    #                 res_upper,")",sep = "")
    return(res_pre)
  }
  
  
  fivey = read.table("5-year Survival Probability.txt",header = T,sep = "\t",
                     row.names = 1,stringsAsFactors = F)
  fivey = fivey[order(fivey[,1]),]
  
  ProbalilityFive <- function(x) {
    temp = rank(c(x,fivey[,1]))
    #res_upper = sprintf("%1.2f%%",(fivey[temp[1]-1,2])*100)
    #res_lower = sprintf("%1.2f%%",(fivey[temp[1],2])*100)
    res_pre =  sprintf("%1.2f%%",((fivey[temp[1]-1,2] + fivey[temp[1],2])/2)*100)
    #res_prob = paste(res_pre," (",
    #                res_lower," - ",
    #                 res_upper,")",sep = "")
    return(res_pre)
  }
  test <- reactive({
    input$action_Calc
    dataname = paste(isolate(input$DataType),".txt",sep="")
    data_qPCR = read.table(dataname,header = T,row.names = 1,
                           sep="\t",stringsAsFactors = F)
    return(data_qPCR)
  })
  
  
  # data_affy = read.table("1.txt",header = T,row.names = 1,
  #                       sep="\t",stringsAsFactors = F)
  #data_ill = read.table("2.txt",header = T,row.names = 1,
  #                      sep="\t",stringsAsFactors = F)
  
  #data_RNASeq = read.table("3.txt",header = T,row.names = 1,
  #                      sep="\t",stringsAsFactors = F)
  #data_qPCR = read.table("4.txt",header = T,row.names = 1,
  #                      sep="\t",stringsAsFactors = F)
  
  qPCR_GRS_calculate = function(){
    APOD_normal_data = as.numeric(test()$APOD)
    APOD_matrix = c(APOD_normal_data,input$APOD)
    APOD_norm = (input$APOD-mean(APOD_matrix))/sd(APOD_matrix)
    CCDC92_normal_data = as.numeric(test()$CCDC92)
    CCDC92_matrix = c(CCDC92_normal_data,input$CCDC92)
    CCDC92_norm = (input$CCDC92-mean(CCDC92_matrix))/sd(CCDC92_matrix)
    CYS1_normal_data = as.numeric(test()$CYS1)
    CYS1_matrix = c(CYS1_normal_data,input$CYS1)
    CYS1_norm = (input$CYS1-mean(CYS1_matrix))/sd(CYS1_matrix)
    GSDME_normal_data = as.numeric(test()$GSDME)
    GSDME_matrix = c(GSDME_normal_data,input$GSDME)
    GSDME_norm = (input$GSDME-mean(GSDME_matrix))/sd(GSDME_matrix)
    STARD3NL_normal_data = as.numeric(test()$STARD3NL)
    STARD3NL_matrix = c(STARD3NL_normal_data,input$STARD3NL)
    STARD3NL_norm = (input$STARD3NL-mean(STARD3NL_matrix))/sd(STARD3NL_matrix)
    ST8SIA5_normal_data = as.numeric(test()$ST8SIA5)
    ST8SIA5_matrix = c(ST8SIA5_normal_data,input$ST8SIA5)
    ST8SIA5_norm = (input$ST8SIA5-mean(ST8SIA5_matrix))/sd(ST8SIA5_matrix)
    TMEM245_normal_data = as.numeric(test()$TMEM245)
    TMEM245_matrix = c(TMEM245_normal_data,input$TMEM245)
    TMEM245_norm = (input$TMEM245-mean(TMEM245_matrix))/sd(TMEM245_matrix)
    TSPYL5_normal_data = as.numeric(test()$TSPYL5)
    TSPYL5_matrix = c(TSPYL5_normal_data,input$TSPYL5)
    TSPYL5_norm = (input$TSPYL5-mean(TSPYL5_matrix))/sd(TSPYL5_matrix)
    VAT1_normal_data = as.numeric(test()$VAT1)
    VAT1_matrix = c(VAT1_normal_data,input$VAT1)
    VAT1_norm = (input$VAT1-mean(VAT1_matrix))/sd(VAT1_matrix)
    res = APOD_norm*0.01+CCDC92_norm*0.264+CYS1_norm*0.176+GSDME_norm*0.262+STARD3NL_norm*0.412
    -ST8SIA5_norm*0.308+TMEM245_norm*0.028+TSPYL5_norm*0.189+VAT1_norm*0.249
    return(res)
  }
  
  values <- reactiveValues()
  observe({
    input$action_Calc
    values$GRS <- isolate({
      qPCR_GRS_calculate()
    })
    values$CRS <- isolate({
      input$Age * 0.021 +
        recode(input$Stage, "1 = '0'; 2 = '0.31'; 
               3 = '0.75'; 4 = '1.56'")  
    })
    values$CGRS <- isolate({
      1.25*values$CRS + 0.88*values$GRS
    })
    values$one <- isolate({
      ProbalilityOne(values$CGRS)
    })
    values$three <- isolate({
      ProbalilityThree(values$CGRS)
    })
    values$five <- isolate({
      ProbalilityFive(values$CGRS)
    })
    })
  
  # Create the wordcloud
  output$text_APOD <- renderText({
    input$action_Calc
    paste("APOD expression level: ", isolate(input$APOD))
  })
  output$text_CCDC92 <- renderText({
    input$action_Calc
    paste("CCDC92 expression level: ", isolate(input$CCDC92))
  })
  output$text_CYS1 <- renderText({
    input$action_Calc
    paste("CYS1 expression level: ", isolate(input$CYS1))
  })
  output$text_GSDME <- renderText({
    input$action_Calc
    paste("GSDME expression level: ", isolate(input$GSDME))
  })
  output$text_ST8SIA5 <- renderText({
    input$action_Calc
    paste("ST8SIA5 expression level: ", isolate(input$ST8SIA5))
  })
  output$text_STARD3NL <- renderText({
    input$action_Calc
    paste("STARD3NL expression level: ", isolate(input$STARD3NL))
  })
  output$text_TMEM245 <- renderText({
    input$action_Calc
    paste("TMEM245 expression level: ", isolate(input$TMEM245))
  })
  output$text_TSPYL5 <- renderText({
    input$action_Calc
    paste("TSPYL5 expression level: ", isolate(input$TSPYL5))
  })
  output$text_VAT1 <- renderText({
    input$action_Calc
    paste("VAT1 expression level: ", isolate(input$VAT1))
  })
  output$text_stage <- renderText({
    input$action_Calc
    paste("AJCC Stage for GC patient: Stage ", isolate(input$Stage))
  })
  output$text_age <- renderText({
    input$action_Calc
    paste("Age for GC patient: ", isolate(input$Age), " years old")
  })
  output$text_type <- renderText({
    input$action_Calc
    paste("Data type: ",recode(isolate(input$DataType),
                               "1 = 'Affymetrix Microarray' ;
                               2 = 'Illumina Microarray' ; 
                               3 = 'RNASeq';
                               4 = 'qRT-PCR' "))})
  output$text_GRS <- renderText({
    if(input$action_Calc == 0) ""
    else
      paste("Genetic Risk score:", round(values$GRS,3))
  })
  
  output$text_CRS <- renderText({
    if(input$action_Calc == 0) ""
    else
      paste("Clinic Risk score:", round(values$CRS,3))
  })
  
  output$text_CGRS <- renderText({
    if(input$action_Calc == 0) ""
    else
      paste("Clinic and Genetic Risk score:", round(values$CGRS,3))
  })
  
  
  output$text_1year <- renderText({
    if(input$action_Calc == 0) ""
    else
      paste("The one year Survival Probability is :", values$one)
  })
  
  output$text_3year <- renderText({
    if(input$action_Calc == 0) ""
    else
      paste("The three year Survival Probability is :", values$three)
  })
  
  output$text_5year <- renderText({
    if(input$action_Calc == 0) ""
    else
      paste("The five year Survival Probability is :", values$five)
  })
  
})
