
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

paths = list.dirs("time_comparison", full.names=F)[-1]

pdf("time_comparison/time_comparison.pdf", width=12, height=9)
for(p in paths){
    
    files = list.files(paste0("time_comparison/", p), pattern = "*txt")
    
    plot_list = list()
    speedup_plot = list()
    
    for(f in files){
        opt = strsplit(f, split="[.]")[[1]][1]
        
        df = read.table(paste0("time_comparison/", p, "/", f), header=TRUE)
        
        df_text = data.frame(
            x_pos = max(df$n)/2,
            y_pos = max(df$clock_ms)*0.9,
            text = ifelse(
                p=="cut_10000",
                "cut: 10.000",
                "cut: n*0.87"
            )
        )
        
        plot_list[[opt]] = ggplot(df, aes(x=n, y=clock_ms)) +
            geom_point(aes(color=method)) +
            labs(title=paste0("time (clock) - ", opt)) +
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
        
        df_speedup = data.frame()
        
        for(n in unique(df$n)){
            df_aux = df[df$n==n,]
            
            df_speedup = rbind(df_speedup, data.frame(
                n = n,
                cut = unique(df_aux$cut),
                speedup = df_aux[df_aux$method=="Quick_sort","clock_ms"] / df_aux[df_aux$method=="Quick_bubble_sort","clock_ms"]
            ))
        }
        
        speedup_plot[[opt]] = ggplot(df_speedup, aes(x=n, y=speedup)) +
            geom_point() +
            labs(
                title = paste0(
                    "SpeedUp - ",
                    opt,
                    " - ",
                    ifelse(
                        p=="cut_10000",
                        "cut: 10.000",
                        "cut: n*0.87"
                    )
                )
            ) +
            theme(
                panel.background = element_blank()
            )
    }
    
    ####################################################################
    
    grid.arrange(grobs=plot_list)
    grid.arrange(grobs=speedup_plot)
}
dev.off()
