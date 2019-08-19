
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

library(ggplot2)
library(gridExtra)

graphics.off()
options(scipen = 999)

########################################################################

paths = list.dirs("iter_comparison", full.names=F)[-1]

pdf("iter_comparison/iter_comparison.pdf", width=12, height=9)
for(p in paths){
    
    files = list.files(paste0("iter_comparison/", p), pattern = "*txt")
    
    plot_list = list()
    
    for(f in files){
        opt = strsplit(f, split="[.]")[[1]][1]
        
        df = read.table(paste0("iter_comparison/", p, "/", f), header=TRUE)
        
        df_text = data.frame(
            x_pos = max(df$n)/2,
            y_pos = max(df$iter)*0.9,
            text = ifelse(
                p=="cut_10000",
                "cut: 10.000",
                "cut: n*0.87"
            )
        )
        
        plot_list[[opt]] = ggplot(df, aes(x=n, y=iter)) +
            geom_point(aes(color=method), size=0.8) +
            labs(title=opt) +
            theme(
                panel.background = element_blank()
            ) +
            geom_text(
                data = df_text,
                aes(x=x_pos, y=y_pos, label=text)
            )
        
        # for(m in unique(as.character(df$method))){
        #     plot_list[[opt]] = plot_list[[opt]] +
        #         stat_smooth(
        #             geom = "line",
        #             data = subset(df, method==m),
        #             color = "black",
        #             alpha = 0.7,
        #             size = 1,
        #             se = FALSE,
        #             method = "lm",
        #             formula = y ~ poly(x, 4, raw=T)
        #         )
        # }
    }
    
    ####################################################################
    
    grid.arrange(grobs=plot_list)
}
dev.off()
