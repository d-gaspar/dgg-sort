
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

library(ggplot2)

graphics.off()
options(scipen = 999)

########################################################################

paths = list.dirs("otimize_cut_parameter", full.names=F)[-1]
paths = paths[order(as.numeric(paths))]

pdf("otimize_cut_parameter/otimize_cut_parameter.pdf", width=12, height=9)
for(p in paths){
    
    files = list.files(paste0("otimize_cut_parameter/", p))
    
    df = data.frame()
    
    for(f in files){
        opt = strsplit(f, split="[.]")[[1]][1]
        
        df_aux = read.table(paste0("otimize_cut_parameter/", p, "/", f), header=TRUE)
        df_aux$n = p
        df_aux$opt = opt
        
        df = rbind(df, df_aux)
    }
    
    opts = unique(df$opt)
    
    max_clock_ms = as.numeric(lapply(split(df, df$opt), function(x) max(x$clock_ms))[opts])
    min_clock_ms = as.numeric(lapply(split(df, df$opt), function(x) min(x$clock_ms))[opts])
    
    cut_min = c()
    clock_ms_min = c()
    lm_cut_min = c()
    lm_clock_ms_min = c()
    for(o in opts){
        df_aux = subset(df, opt==o)
        
        cut_min = c(cut_min, df_aux[which.min(df_aux$clock_ms),"cut"])
        clock_ms_min = c(clock_ms_min, min(df_aux$clock_ms))
        
        lm_cut = lm(clock_ms ~ poly(cut, 4, raw=T), df_aux)
        fits = lm_cut$fitted.values
        
        lm_cut_min = c(lm_cut_min, df_aux[which.min(fits),"cut"])
        lm_clock_ms_min = c(lm_clock_ms_min, round(as.numeric(min(fits)),2))
    }
    
    lm_min = data.frame(
        x_pos = median(df$cut),
        y_pos = max_clock_ms*0.9,
        opt = opts,
        text = paste0(
            "MIN\n",
            "cut:", cut_min, "; clock_ms:", clock_ms_min, "\n",
            "(reg.) cut:", lm_cut_min, "; clock_ms:", lm_clock_ms_min
        )
    )
    
    print(
        ggplot(df, aes(x=cut, y=clock_ms)) +
            labs(title=p) +
            geom_point() +
            geom_smooth(se=F, method="lm", fill=NA, formula=y ~ poly(x, 4, raw=T)) +
            geom_text(
                data = lm_min,
                aes(x=x_pos, y=y_pos, label=text)
            ) +
            theme(
                panel.background = element_blank()
            ) +
            facet_wrap(
                opt ~ .,
                scales = "free"
            )
    )
}
dev.off()
