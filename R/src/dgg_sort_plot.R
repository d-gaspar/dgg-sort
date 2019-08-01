
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

# library(ggplot2)

########################################################################

dgg_sort_plot = function(array, comparison=c(), sorted=c(), title=""){
    
    colors = rep("white", length(array))
    if(length(comparison)>0){
        colors[comparison[1]] = "red"
        colors[comparison[2]] = "green"
    }
    if(length(sorted)>0){
        colors[sorted] = "yellow"
    }
    
    p = ggplot(data=as.data.frame(array), aes(x=1:length(array), y=array)) +
        geom_bar(stat="identity", color="black", fill=colors) +
        theme(
            panel.background = element_blank(),
            # panel.border = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.title=element_blank(),
            axis.text=element_blank(),
            axis.ticks=element_blank(),
            plot.title = element_text(color="white", size=10, face="bold", hjust=0),
            plot.background = element_rect(fill = "black", color="white")
        )
    
    if(title!=""){
        p = p +
            ggtitle(title)
    }
    
    return(p)
}
