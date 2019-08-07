
########################################################################
#                                                                      #
# AUTHOR: Daniel Gaspar Goncalves                                      #
# git: https://github.com/d-gaspar/                                    #
#                                                                      #
########################################################################

library(ggplot2)
library(magick)
library(dplyr)
library(grid)
library(gridExtra)

graphics.off()
dir.create("output", showWarnings=F)

source("src/dgg_sort_plot.R")

########################################################################

# CREATE ARRAY

n = 10

# random
set.seed(42)
array_1 = sample(1:n, n)

# nearly sorted
array_2 = 1:n
aux = array_2[1:n %% 3==0]
array_2[1:n %% 3==0] = array_2[1:n %% 3==2][1:length(aux)]
array_2[1:n %% 3==2][1:length(aux)] = aux

# reversed
array_3 = n:1

# few unique
set.seed(42)
array_4 = sample(1:floor(n/3), n, replace=TRUE)

########################################################################

# bubble_sort

source("src/bubble_sort.R")

bubble_1 = bubble_sort_verbose(array_1)
bubble_2 = bubble_sort_verbose(array_2)
bubble_3 = bubble_sort_verbose(array_3)
bubble_4 = bubble_sort_verbose(array_4)

########################################################################

# selection_sort

source("src/selection_sort.R")

selection_1 = selection_sort_verbose(array_1)
selection_2 = selection_sort_verbose(array_2)
selection_3 = selection_sort_verbose(array_3)
selection_4 = selection_sort_verbose(array_4)

########################################################################

# merge_sort

source("src/merge_sort.R")

merge_1 = merge_sort_verbose(array_1)$output
merge_2 = merge_sort_verbose(array_2)$output
merge_3 = merge_sort_verbose(array_3)$output
merge_4 = merge_sort_verbose(array_4)$output

########################################################################

source("src/dgg_sort.R")

dgg_1 = dgg_sort_verbose(array_1)$output
dgg_2 = dgg_sort_verbose(array_2)$output
dgg_3 = dgg_sort_verbose(array_3)$output
dgg_4 = dgg_sort_verbose(array_4)$output

########################################################################

# PLOT

max_comparisons = max(
    length(bubble_1), length(bubble_2), length(bubble_3), length(bubble_4),
    length(selection_1), length(selection_2), length(selection_3), length(selection_4),
    length(merge_1), length(merge_2), length(merge_3), length(merge_4),
    length(dgg_1), length(dgg_2), length(dgg_3), length(dgg_4)
)

png("output/sort_animation%03d.png", width=800, height=600, bg = "black")
for(i in 1:(max_comparisons+1)){

    # bubble_sort - random
    if(i <= length(bubble_1)){
        p1 = dgg_sort_plot(
            array = bubble_1[[i]]$array,
            comparison = bubble_1[[i]]$comparison,
            sorted = bubble_1[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                bubble_1[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p1 = dgg_sort_plot(
            array = sort(array_1),
            sorted = 1:n,
            title = paste0(
                length(bubble_1), " comparisons; ",
                bubble_1[[length(bubble_1)]]$n_swaps, " swaps"
            )
        )
    }
    
    # bubble_sort - nearly sorted
    if(i <= length(bubble_2)){
        p2 = dgg_sort_plot(
            array = bubble_2[[i]]$array,
            comparison = bubble_2[[i]]$comparison,
            sorted = bubble_2[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                bubble_2[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p2 = dgg_sort_plot(
            array = sort(array_2),
            sorted = 1:n,
            title = paste0(
                length(bubble_2), " comparisons; ",
                bubble_2[[length(bubble_2)]]$n_swaps, " swaps"
            )
        )
    }
    
    # bubble_sort - reversed
    if(i <= length(bubble_3)){
        p3 = dgg_sort_plot(
            array = bubble_3[[i]]$array,
            comparison = bubble_3[[i]]$comparison,
            sorted = bubble_3[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                bubble_3[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p3 = dgg_sort_plot(
            array = sort(array_3),
            sorted = 1:n,
            title = paste0(
                length(bubble_3), " comparisons; ",
                bubble_3[[length(bubble_3)]]$n_swaps, " swaps"
            )
        )
    }
    
    # bubble_sort - few unique
    if(i <= length(bubble_4)){
        p4 = dgg_sort_plot(
            array = bubble_4[[i]]$array,
            comparison = bubble_4[[i]]$comparison,
            sorted = bubble_4[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                bubble_4[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p4 = dgg_sort_plot(
            array = sort(array_4),
            sorted = 1:n,
            title = paste0(
                length(bubble_4), " comparisons; ",
                bubble_4[[length(bubble_4)]]$n_swaps, " swaps"
            )
        )
    }
    
    ####################################################################
    
    # selection_sort - random
    if(i <= length(selection_1)){
        p5 = dgg_sort_plot(
            array = selection_1[[i]]$array,
            comparison = selection_1[[i]]$comparison,
            sorted = selection_1[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                selection_1[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p5 = dgg_sort_plot(
            array = sort(array_1),
            sorted = 1:n,
            title = paste0(
                length(selection_1), " comparisons; ",
                selection_1[[length(selection_1)]]$n_swaps, " swaps"
            )
        )
    }
    
    # selection_sort - nearly sorted
    if(i <= length(selection_2)){
        p6 = dgg_sort_plot(
            array = selection_2[[i]]$array,
            comparison = selection_2[[i]]$comparison,
            sorted = selection_2[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                selection_2[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p6 = dgg_sort_plot(
            array = sort(array_2),
            sorted = 1:n,
            title = paste0(
                length(selection_2), " comparisons; ",
                selection_2[[length(selection_2)]]$n_swaps, " swaps"
            )
        )
    }
    
    # selection_sort - reversed
    if(i <= length(selection_3)){
        p7 = dgg_sort_plot(
            array = selection_3[[i]]$array,
            comparison = selection_3[[i]]$comparison,
            sorted = selection_3[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                selection_3[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p7 = dgg_sort_plot(
            array = sort(array_3),
            sorted = 1:n,
            title = paste0(
                length(selection_3), " comparisons; ",
                selection_3[[length(selection_3)]]$n_swaps, " swaps"
            )
        )
    }
    
    # selection_sort - few unique
    if(i <= length(selection_4)){
        p8 = dgg_sort_plot(
            array = selection_4[[i]]$array,
            comparison = selection_4[[i]]$comparison,
            sorted = selection_4[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                selection_4[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p8 = dgg_sort_plot(
            array = sort(array_4),
            sorted = 1:n,
            title = paste0(
                length(selection_4), " comparisons; ",
                selection_4[[length(selection_4)]]$n_swaps, " swaps"
            )
        )
    }
    
    ####################################################################
    
    # merge_sort - random
    if(i <= length(merge_1)){
        p13 = dgg_sort_plot(
            array = merge_1[[i]]$array,
            comparison = merge_1[[i]]$comparison,
            title = paste0(
                i, " comparisons; ",
                merge_1[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p13 = dgg_sort_plot(
            array = sort(array_1),
            sorted = 1:n,
            title = paste0(
                length(merge_1), " comparisons; ",
                merge_1[[length(merge_1)]]$n_swaps, " swaps"
            )
        )
    }
    
    # merge_sort - nearly sorted
    if(i <= length(merge_2)){
        p14 = dgg_sort_plot(
            array = merge_2[[i]]$array,
            comparison = merge_2[[i]]$comparison,
            title = paste0(
                i, " comparisons; ",
                merge_2[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p14 = dgg_sort_plot(
            array = sort(array_2),
            sorted = 1:n,
            title = paste0(
                length(merge_2), " comparisons; ",
                merge_2[[length(merge_2)]]$n_swaps, " swaps"
            )
        )
    }
    
    # merge_sort - reversed
    if(i <= length(merge_3)){
        p15 = dgg_sort_plot(
            array = merge_3[[i]]$array,
            comparison = merge_3[[i]]$comparison,
            title = paste0(
                i, " comparisons; ",
                merge_3[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p15 = dgg_sort_plot(
            array = sort(array_3),
            sorted = 1:n,
            title = paste0(
                length(merge_3), " comparisons; ",
                merge_3[[length(merge_3)]]$n_swaps, " swaps"
            )
        )
    }
    
    # merge_sort - few unique
    if(i <= length(merge_4)){
        p16 = dgg_sort_plot(
            array = merge_4[[i]]$array,
            comparison = merge_4[[i]]$comparison,
            title = paste0(
                i, " comparisons; ",
                merge_4[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p16 = dgg_sort_plot(
            array = sort(array_4),
            sorted = 1:n,
            title = paste0(
                length(merge_4), " comparisons; ",
                merge_4[[length(merge_4)]]$n_swaps, " swaps"
            )
        )
    }
    
    ####################################################################
    
    # dgg_sort - random
    if(i <= length(dgg_1)){
        p21 = dgg_sort_plot(
            array = dgg_1[[i]]$array,
            comparison = dgg_1[[i]]$comparison,
            sorted = dgg_1[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                dgg_1[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p21 = dgg_sort_plot(
            array = sort(array_1),
            sorted = 1:n,
            title = paste0(
                length(dgg_1), " comparisons; ",
                dgg_1[[length(dgg_1)]]$n_swaps, " swaps"
            )
        )
    }
    
    # dgg_sort - nearly sorted
    if(i <= length(dgg_2)){
        p22 = dgg_sort_plot(
            array = dgg_2[[i]]$array,
            comparison = dgg_2[[i]]$comparison,
            sorted = dgg_2[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                dgg_2[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p22 = dgg_sort_plot(
            array = sort(array_2),
            sorted = 1:n,
            title = paste0(
                length(dgg_2), " comparisons; ",
                dgg_2[[length(dgg_2)]]$n_swaps, " swaps"
            )
        )
    }
    
    # dgg_sort - reversed
    if(i <= length(dgg_3)){
        p23 = dgg_sort_plot(
            array = dgg_3[[i]]$array,
            comparison = dgg_3[[i]]$comparison,
            sorted = dgg_3[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                dgg_3[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p23 = dgg_sort_plot(
            array = sort(array_3),
            sorted = 1:n,
            title = paste0(
                length(dgg_3), " comparisons; ",
                dgg_3[[length(dgg_3)]]$n_swaps, " swaps"
            )
        )
    }
    
    # dgg_sort - few unique
    if(i <= length(dgg_4)){
        p24 = dgg_sort_plot(
            array = dgg_4[[i]]$array,
            comparison = dgg_4[[i]]$comparison,
            sorted = dgg_4[[i]]$sorted,
            title = paste0(
                i, " comparisons; ",
                dgg_4[[i]]$n_swaps, " swaps"
            )
        )
    } else {
        p24 = dgg_sort_plot(
            array = sort(array_4),
            sorted = 1:n,
            title = paste0(
                length(dgg_4), " comparisons; ",
                dgg_4[[length(dgg_4)]]$n_swaps, " swaps"
            )
        )
    }
    
    ####################################################################
    
    r1 = textGrob("Random", gp=gpar(fontsize=15, fontface="bold", col="white"), rot=90, vjust=0.5)
    r2 = textGrob("Nearly sorted", gp=gpar(fontsize=15, fontface="bold", col="white"), rot=90, vjust=0.5)
    r3 = textGrob("Reverse", gp=gpar(fontsize=15, fontface="bold", col="white"), rot=90, vjust=0.5)
    r4 = textGrob("Few unique", gp=gpar(fontsize=15, fontface="bold", col="white"), rot=90, vjust=0.5)
    c1 = textGrob("Bubble", gp=gpar(fontsize=15, fontface="bold", col="white"), vjust=0.5)
    c2 = textGrob("Selection", gp=gpar(fontsize=15, fontface="bold", col="white"), vjust=0.5)
    # c3 = textGrob("Insertion", gp=gpar(fontsize=15, fontface="bold", col="white"), vjust=0.5)
    c4 = textGrob("Merge", gp=gpar(fontsize=15, fontface="bold", col="white"), vjust=0.5)
    # c5 = textGrob("Quick", gp=gpar(fontsize=15, fontface="bold", col="white"), vjust=0.5)
    c6 = textGrob("DGG", gp=gpar(fontsize=15, fontface="bold", col="white"), vjust=0.5)
    
    # plot figures
    grid.arrange(
        layout_matrix = rbind(
            c(NA,94,94,94,95,95,95,97,97,97,99,99,99),
            c(90,1,1,1,5,5,5,9,9,9,21,21,21),
            c(90,1,1,1,5,5,5,9,9,9,21,21,21),
            c(90,1,1,1,5,5,5,9,9,9,21,21,21),
            c(91,2,2,2,6,6,6,10,10,10,22,22,22),
            c(91,2,2,2,6,6,6,10,10,10,22,22,22),
            c(91,2,2,2,6,6,6,10,10,10,22,22,22),
            c(92,3,3,3,7,7,7,11,11,11,23,23,23),
            c(92,3,3,3,7,7,7,11,11,11,23,23,23),
            c(92,3,3,3,7,7,7,11,11,11,23,23,23),
            c(93,4,4,4,8,8,8,12,12,12,24,24,24),
            c(93,4,4,4,8,8,8,12,12,12,24,24,24),
            c(93,4,4,4,8,8,8,12,12,12,24,24,24)
        ),p1,p2,p3,p4,p5,p6,p7,p8,p13,p14,p15,p16,p21,p22,p23,p24,
        r1,r2,r3,r4,
        c1,c2,c4,c6#,c3,c4,c5,c6
    )
}
dev.off()

########################################################################

# generate animation (.gif)

list.files(path = "output", pattern=".png", full.names=TRUE) %>% 
    image_read() %>% # reads each path file
    image_join() %>% # joins image
    image_animate(fps=1, loop=1) %>% # animates, can opt for number of loops
    image_write("output/sort_animation.gif")

# cleaning up
file.remove(paste0("output/", list.files(path = "output", pattern=".png")))
