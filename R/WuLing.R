# this script is for Wu-Ling 2018.
# It includes several parts: data cleaning, data manipulation, visualization, and combine plots into big figures.

# For 2018, I want to combine data from all sub-projects. see the variation along time.
# https://www.r-bloggers.com/multiple-y-axis-in-a-r-plot/

library(data.table)
library(dplyr)
library(ggplot2)
library(stringr)
library(measurements)
library(zoo)
library(gridExtra)


# algae 2018 ==========
algae2018 <- fread('/Users/yiju/GoogleDrive/spnp-wlterm/algae2018.csv')

# select columns 
algae2018 <- algae2018[, c('測站代號', '調查日期', '生物量')]

# rename column names
algae2018 <- rename(algae2018, id = 測站代號, date = 調查日期, biomass = 生物量)

# remove blank rows
algae2018 <- algae2018[complete.cases(algae2018$biomass), ]
which(algae2018$biomass == 0) # none

algae2018$date <- as.Date(algae2018$date)

# calculate the monthly average value
algae2018.mean <- algae2018 %>% 
    group_by(id, date) %>% 
    summarise(mean.bio = mean(biomass), Project_id = '1')


ggplot(algae2018.mean , aes(date, mean.bio, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    facet_grid(~id) + # this line is optional
    labs(title = '2018各樣站每月藻類平均葉綠素a濃度', x = '日期', y = '平均葉綠素a濃度', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))
    
# example for one site, several sub project ======
ggplot(algae2018.mean[algae2018.mean$id == '13', ] , aes(date, mean.bio, colour = as.character(Project_id) )) + 
    geom_line() + 
    geom_point() +
    facet_grid(~id) + # this line is optional
    labs(title = '2018各子計畫', x = '日期', y = '平均葉綠素a濃度', color='子計畫') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))
# !!Notice: different sub-project with different y scale......

# amphibia 2018 =====
amphibia2018 <- fread('/Users/yiju/GoogleDrive/spnp-wlterm/amphibia2018.csv')
summary(amphibia2018)

# select columns 
amphibia2018 <- amphibia2018[, c("測站編號", "調查日期(yy/mm/dd)", "V8", "數量")]

# rename column names
amphibia2018 <- rename(amphibia2018, id = "測站編號", date = "調查日期(yy/mm/dd)", notes = "V8", individual_count = "數量")

# remove blank rows
amphibia2018 <- amphibia2018[complete.cases(amphibia2018$individual_count), ]
which(amphibia2018$individual_count == 0) # none

amphibia2018$date <- as.Date(amphibia2018$date)


# calculate frog total number of each month
amphibia2018.total <- amphibia2018 %>% 
    mutate(date = as.Date(as.yearmon(substr(amphibia2018$date, start = 1, stop = 7)))) %>% 
    group_by(id, date, notes) %>% 
    summarise(total = sum(individual_count), Project_id = '9')

## as.Date will fix the first day of each month to a yearmon object automatically


ggplot(amphibia2018.total[amphibia2018.total$notes == '成蛙', ] , aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    facet_grid(~id) + # this line is optional
    labs(title = '2018各樣站每月成蛙總數', x = '日期', y = '成蛙總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))


ggplot(amphibia2018.total[amphibia2018.total$notes == '成蛙', ] , aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月成蛙總數', x = '月份', y = '成蛙總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))


# fish all ======
fish.all <- fread('/Users/yiju/GoogleDrive/spnp-wlterm/fishAll.csv')

# select columns 
fish.all <- fish.all[, c("測站代號", "調查日期", "拉丁學名", "生物量")]

# rename column names
fish.all <- rename(fish.all, id = "測站代號", date = "調查日期", scientific_name = "拉丁學名", biomass = "生物量")

# remove blank rows
fish.all <- fish.all[complete.cases(fish.all$biomass), ]
which(fish.all$biomass == 0) 
fish.all <- fish.all[fish.all$biomass != 0, ]

# fish 2018 =======
fish2018 <- fish.all[ 873:1001, ]

fish2018$date <- as.Date(gsub('.', '-', fish2018$date, fixed = T))

levels(as.factor(fish2018$scientific_name))
    
    
# calculate fish total number of each month
fish2018.total <- fish2018 %>% 
    group_by(id, date, scientific_name) %>% 
    summarise(total = sum(biomass), Project_id = '10')

    
ggplot(fish2018.total[fish2018.total$scientific_name == "Oncorhynchus formosanus", ] , aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月臺灣櫻花鉤吻鮭總數', x = '日期', y = '魚總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

sum(fish2018.total$total) # 4206

# bird 2018 ======
bird2018 <- fread('/Users/yiju/GoogleDrive/spnp-wlterm/bird2018_2.csv')

bird2018 <- bird2018 %>% 
    select("調查日期(yyyymmdd)", "物種名稱", "數量", "其他") %>% 
    mutate(id = dplyr::recode(bird2018$其他, '桃山西溪' = '2', '二號壩' = '3', '觀魚台' = '4', '一號壩上游' = '12', '一號壩下游' = '13', '繁殖場' = '5', '高山溪' = '8', '有勝溪' = '9')) %>% 
    rename(date = "調查日期(yyyymmdd)", notes = "物種名稱", individual_count = "數量") %>% 
    filter(notes == "河烏") %>% 
    mutate(date = as.Date(as.character(date), "%Y%m%d"))


# calculate bird 河烏 total number of each month
bird2018.total <- bird2018 %>% 
    group_by(id, date) %>% 
    summarise(total = sum(individual_count), Project_id = '11')


ggplot(bird2018.total, aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月河烏總數', x = '日期', y = '河烏總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

# insect 2018 ========
# combine two dataset
insect2018.1 <- fread('/Users/yiju/GoogleDrive/spnp-wlterm/insect2018_1.csv')
insect2018.2 <- fread('/Users/yiju/GoogleDrive/spnp-wlterm/insect2018_3.csv')


insect2018.1 <- insect2018.1[, -c(11, 13, 14, 15)]
insect2018.2 <- insect2018.2[, -c(12, 13, 14)]

names(insect2018.1) == names(insect2018.2) # TRUE

insect2018 <- rbind(insect2018.1, insect2018.2)

insect2018 <- insect2018[complete.cases(insect2018$數量), ]

insect2018 <- insect2018 %>% 
    select("調查日期(yyyymmdd)", "物種名稱", "數量") %>% 
    mutate(id = dplyr::recode(insect2018$坐標y, "N 24°21'16.1\"\"" = '5', "N 24°21'48.8\"\"" = '12', "N 24°21'49.8\"\"" = '13', "N 24°22'15\"\"" = '4', "N 24°22'55.7\"\"" = '3', "N 24°23'40.4\"\"" = '14', "N 24°23'52.9\"\"" = '2', "N 24°35'87\"\"" = '8', "N 24°58'15\"\"" = '9')) %>% 
    rename(date = "調查日期(yyyymmdd)", notes = "物種名稱", individual_count = "數量") %>% 
    filter(notes == "流石蛾科" ) %>%  # "流石蛾科", "黑管石蛾科"
    mutate(date = as.Date(date))

# claculate the insect 流石蛾科 total number of each month
insect2018.total <- insect2018 %>% 
    group_by(id, date) %>% 
    summarise(total = sum(individual_count), Project_id = '6')


ggplot(insect2018.total, aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月流石蛾科總數', x = '日期', y = '流石蛾科總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))



# water 2018 =====
water2018 <- fread('/Users/yiju/GoogleDrive/spnp-wlterm/water2018.csv')
    
water2018 <- water2018[complete.cases(water2018$氫離子濃度), ]
water2018 <- water2018[1:32, ]

summary(water2018)

water2018 <- water2018 %>% 
    select("測站代號", "調查日期", "溫度(℃)", "溶氧（mg/L）", "硝酸鹽氮（mg/L）", "亞硝酸鹽氮（µg/L）", "總有機碳（mg/L）" ) %>% 
    rename(id = "測站代號", date = "調查日期", Temperature = "溫度(℃)", DO = "溶氧（mg/L）", NO3_N= "硝酸鹽氮（mg/L）", NO2_N = "亞硝酸鹽氮（µg/L）", TOC = "總有機碳（mg/L）") %>% 
    mutate(date = as.Date(date))


ggplot(water2018, aes(date, Temperature, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月溫度', x = '日期', y = '溫度', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

# put all the 2018 plots into one big figure =======
# spe ====
p1 <- ggplot(algae2018.mean , aes(date, mean.bio, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月藻類平均葉綠素a濃度', x = '月份', y = '平均葉綠素a濃度', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))



p2 <- ggplot(amphibia2018.total[amphibia2018.total$notes == '成蛙', ] , aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月成蛙總數', x = '月份', y = '成蛙總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))


p3 <- ggplot(fish2018.total[fish2018.total$scientific_name == "Oncorhynchus formosanus", ] , aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月臺灣櫻花鉤吻鮭總數', x = '月份', y = '櫻花鉤吻鮭總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

p4 <- ggplot(bird2018.total, aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月河烏總數', x = '月份', y = '河烏總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))


p5 <- ggplot(insect2018.total, aes(date, total, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月流石蛾科總數', x = '月份', y = '流石蛾科總數', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

figures2018 <- grid.arrange(p1, p2, p3, p4, p5, nrow = 2, ncol = 3)
ggsave('figures2018.png', plot = figures2018, dpi = 500, width = 36, height = 24, units = 'cm', device = 'png')

# env ====
p6 <- ggplot(water2018, aes(date, Temperature, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月溫度', x = '月份', y = '溫度(℃)', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

p7 <- ggplot(water2018, aes(date, as.numeric(DO), colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月溶氧', x = '月份', y = '溶氧（mg/L）', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

p8 <- ggplot(water2018, aes(date, NO3_N, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月硝酸鹽氮', x = '月份', y = '硝酸鹽氮（mg/L）', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

p9 <- ggplot(water2018, aes(date, as.numeric(NO2_N), colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月亞硝酸鹽氮', x = '月份', y = '亞硝酸鹽氮（µg/L）', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

p10 <- ggplot(water2018, aes(date, TOC, colour = as.character(id) )) + 
    geom_line() + 
    geom_point() +
    
    labs(title = '2018各樣站每月總有機碳', x = '月份', y = '總有機碳（mg/L）', color='樣站') +
    theme(text=element_text(family="蘋方-繁 標準體", size=14))

figures2018.env <- grid.arrange(p6, p7, p8, p9, p10, nrow = 2, ncol = 3)
ggsave('figures2018_env.png', plot = figures2018.env, dpi = 500, width = 36, height = 24, units = 'cm', device = 'png')

# plot all sub-group data of each site into one figure =====
# env as example
# env of site 12 =========== 

# subset env. data of site 12
water2018.12 <- water2018[water2018$id == '12', ]

# plot
png('env12.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.12$date, y = water2018.12$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '12號樣站(一號壩上游)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.12$date, y = water2018.12$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.12$date, format(water2018.12$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# spe of site 12 ===========

# subset species data of site 12
algae2018.mean.12 <- algae2018.mean[algae2018.mean$id == '12', ]
amphibia2018.total.12 <- amphibia2018.total[amphibia2018.total$id == '12', ]
bird2018.total.12 <- bird2018.total[bird2018.total$id == '12', ]
fish2018.total.12 <- fish2018.total[fish2018.total$id == '12', ]
insect2018.total.12 <- insect2018.total[insect2018.total$id == '12', ]


# choose data I need

# algae2018.mean.12: ALL
# frog 
amphibia2018.total.12 <- amphibia2018.total.12[c(2, 4, 6), ]

# bird2018.total.12: ALL
# fish櫻花鉤吻鮭
fish2018.total.12 <- fish2018.total.12[c(2, 4, 6), ]
# insect2018.total.12: ALL

# make the row number of each dataframe are all the same 
empty <- data.frame("id" = '12', "date" = as.Date('2018-02-01'), "scientific_name" = NA, "total" = NA, "Project_id" = '10')
fish2018.total.12 <- rbind.data.frame(empty, fish2018.total.12)

empty2 <- data.frame("id" = '12', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.12 <- rbind.data.frame(empty2, amphibia2018.total.12)

# empty3 <- data.frame("id" = '12', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '11')
# bird2018.total.12 <- rbind.data.frame(bird2018.total.12, empty3)

# empty4 <- data.frame("id" = '12', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.12 <- rbind.data.frame(insect2018.total.12, empty4)


# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])





# plotting 
# dev.new()
png('spe12.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.12$date), y = algae2018.mean.12$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '12號樣站(一號壩上游)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.12$date), y = algae2018.mean.12$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.12$date, y = amphibia2018.total.12$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.12$date, y = amphibia2018.total.12$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.12$date, y = bird2018.total.12$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.12$date, y = bird2018.total.12$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.12$date, y = fish2018.total.12$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.12$date, y = fish2018.total.12$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.12$date, y = insect2018.total.12$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.12$date, y = insect2018.total.12$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.12$date, format(amphibia2018.total.12$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()


# env of site 13 =========== 

# subset env. data of site 13
water2018.13 <- water2018[water2018$id == '13', ]

# plot
png('env13.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.13$date, y = water2018.13$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '13號樣站(一號壩下游)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.13$date, y = water2018.13$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.13$date, format(water2018.13$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# spe of site 13 ===========

# subset species data of site 13
algae2018.mean.13 <- algae2018.mean[algae2018.mean$id == '13', ]
amphibia2018.total.13 <- amphibia2018.total[amphibia2018.total$id == '13', ]
bird2018.total.13 <- bird2018.total[bird2018.total$id == '13', ]
fish2018.total.13 <- fish2018.total[fish2018.total$id == '13', ]
insect2018.total.13 <- insect2018.total[insect2018.total$id == '13', ]


# choose data I need

# algae2018.mean.13: ALL
# frog 
amphibia2018.total.13 <- amphibia2018.total.13[c(2, 4, 6), ]

# bird2018.total.13: ALL
# fish櫻花鉤吻鮭
fish2018.total.13 <- fish2018.total.13[c(2, 4, 6), ]
# insect2018.total.13: ALL

# make the row number of each dataframe are all the same 
empty <- data.frame("id" = '13', "date" = as.Date('2018-02-01'), "scientific_name" = NA, "total" = NA, "Project_id" = '10')
fish2018.total.13 <- rbind.data.frame(empty, fish2018.total.13)

empty2 <- data.frame("id" = '13', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.13 <- rbind.data.frame(empty2, amphibia2018.total.13)

empty3 <- data.frame("id" = '13', "date" = as.Date('2018-07-01'), "total" = NA, "Project_id" = '11')
bird2018.total.13 <- rbind.data.frame(bird2018.total.13[1:2,], empty3, bird2018.total.13[3,])

# empty4 <- data.frame("id" = '13', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.13 <- rbind.data.frame(insect2018.total.13, empty4)
# 

# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])


# plotting 
# dev.new()
png('spe13.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.13$date), y = algae2018.mean.13$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '13號樣站(一號壩下游)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.13$date), y = algae2018.mean.13$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.13$date, y = amphibia2018.total.13$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.13$date, y = amphibia2018.total.13$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.13$date, y = bird2018.total.13$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.13$date, y = bird2018.total.13$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.13$date, y = fish2018.total.13$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.13$date, y = fish2018.total.13$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.13$date, y = insect2018.total.13$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.13$date, y = insect2018.total.13$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.13$date, format(amphibia2018.total.13$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# env of site 8 =========== 

# subset env. data of site 8
water2018.8 <- water2018[water2018$id == '8', ]

# plot
png('env8.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.8$date, y = water2018.8$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '8號樣站(高山溪)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.8$date, y = water2018.8$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$NO2_N), axes = F, ylim = c(0, 6.0), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6.0), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.8$date, format(water2018.8$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()



# spe of site 8 ===========

# subset species data of site 8
algae2018.mean.8 <- algae2018.mean[algae2018.mean$id == '8', ]
amphibia2018.total.8 <- amphibia2018.total[amphibia2018.total$id == '8', ]
bird2018.total.8 <- bird2018.total[bird2018.total$id == '8', ]
fish2018.total.8 <- fish2018.total[fish2018.total$id == '8', ]
insect2018.total.8 <- insect2018.total[insect2018.total$id == '8', ]


# choose data I need

# algae2018.mean.8: ALL
# frog 
amphibia2018.total.8 <- amphibia2018.total.8[c(2, 4, 5), ]

# bird2018.total.8: ALL
# fish櫻花鉤吻鮭
fish2018.total.8 <- fish2018.total.8[c(2, 4), ]
# insect2018.total.8: ALL

# make the row number of each dataframe are all the same 
empty <- data.frame("id" = c('8', '8'), "date" = c(as.Date('2018-02-01'), as.Date('2018-04-01')), "scientific_name" = c(NA, NA), "total" = c(NA, NA), "Project_id" = c('10', '10'))
fish2018.total.8 <- rbind.data.frame(empty, fish2018.total.8)

empty2 <- data.frame("id" = '8', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.8 <- rbind.data.frame(empty2, amphibia2018.total.8)


empty3 <- data.frame("id" = c('8', '8', '8'), "date" = c(as.Date('2018-02-01'), as.Date('2018-04-01'), as.Date('2018-07-01')), "total" = c(NA, NA, NA), "Project_id" = c('11', '11', '11'))
bird2018.total.8 <- rbind.data.frame(empty3, bird2018.total.8)

# empty4 <- data.frame("id" = '8', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.8 <- rbind.data.frame(insect2018.total.8, empty4)


# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])



# plotting 
# dev.new()
png('spe8.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.8$date), y = algae2018.mean.8$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '8號樣站(高山溪)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.8$date), y = algae2018.mean.8$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.8$date, y = amphibia2018.total.8$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.8$date, y = amphibia2018.total.8$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")


# # Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.8$date, y = bird2018.total.8$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.8$date, y = bird2018.total.8$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.8$date, y = fish2018.total.8$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.8$date, y = fish2018.total.8$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.8$date, y = insect2018.total.8$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.8$date, y = insect2018.total.8$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.8$date, format(amphibia2018.total.8$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類','鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()


# env of site 9 =========== 

# subset env. data of site 9
water2018.9 <- water2018[water2018$id == '9', ]

# plot
png('env9.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.9$date, y = water2018.9$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '9號樣站(有勝溪)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.9$date, y = water2018.9$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.9$date, format(water2018.9$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# env of site 2 =========== 

# subset env. data of site 2
water2018.2 <- water2018[water2018$id == '2', ]

# plot
png('env2.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.2$date, y = water2018.2$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '2號樣站(桃山西溪)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.2$date, y = water2018.2$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.2$date, format(water2018.2$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# env of site 3 =========== 

# subset env. data of site 3
water2018.3 <- water2018[water2018$id == '3', ]

# plot
png('env3.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.3$date, y = water2018.3$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '3號樣站(二號壩)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.3$date, y = water2018.3$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.3$date, format(water2018.3$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()


# env of site 4 =========== 

# subset env. data of site 4
water2018.4 <- water2018[water2018$id == '4', ]

# plot
png('env4.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.4$date, y = water2018.4$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '4號樣站(觀魚台)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.4$date, y = water2018.4$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.4$date, format(water2018.4$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# env of site 5 =========== 

# subset env. data of site 5
water2018.5 <- water2018[water2018$id == '5', ]

# plot
png('env5.png', width = 36, height = 24, units = 'cm', res = 500)
# Define Margins. The trick is to use give as much space possible on the left margin (second value)
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.5$date, y = water2018.5$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '5號樣站(繁殖場)2018環境因子', family = "蘋方-繁 標準體")
points(x = water2018.5$date, y = water2018.5$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.5$date, format(water2018.5$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()



# put the env of all sites plots together into one big figure (1) ========
png('env-allsites1.png', width = 36*2, height = 24*2, units = 'cm', res = 500)
par(mfrow = c(2, 2))

# 
# env of site 2 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.2$date, y = water2018.2$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '2號樣站(桃山西溪)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.2$date, y = water2018.2$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.2$date, y = as.numeric(water2018.2$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.2$date, y = as.numeric(water2018.2$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.2$date, format(water2018.2$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)



# env of site 3 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.3$date, y = water2018.3$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '3號樣站(二號壩)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.3$date, y = water2018.3$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.3$date, y = as.numeric(water2018.3$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.3$date, y = as.numeric(water2018.3$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.3$date, format(water2018.3$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)


# env of site 4 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.4$date, y = water2018.4$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '4號樣站(觀魚台)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.4$date, y = water2018.4$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.4$date, y = as.numeric(water2018.4$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.4$date, y = as.numeric(water2018.4$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.4$date, format(water2018.4$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

# env of site 5 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.5$date, y = water2018.5$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '5號樣站(繁殖場)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.5$date, y = water2018.5$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.5$date, y = as.numeric(water2018.5$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.5$date, y = as.numeric(water2018.5$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.5$date, format(water2018.5$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)



dev.off()

# put the env of all sites plots together into one big figure (2)========
png('env-allsites2.png', width = 36*2, height = 24*2, units = 'cm', res = 500)
par(mfrow = c(2, 2))


# env of site 8 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.8$date, y = water2018.8$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '8號樣站(高山溪)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.8$date, y = water2018.8$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$NO2_N), axes = F, ylim = c(0, 6.0), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6.0), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.8$date, y = as.numeric(water2018.8$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.8$date, y = as.numeric(water2018.8$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.8$date, format(water2018.8$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

# env of site 9 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.9$date, y = water2018.9$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '9號樣站(有勝溪)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.9$date, y = water2018.9$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.9$date, y = as.numeric(water2018.9$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.9$date, y = as.numeric(water2018.9$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.9$date, format(water2018.9$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

# env of site 12 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.12$date, y = water2018.12$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '12號樣站(一號壩上游)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.12$date, y = water2018.12$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.12$date, y = as.numeric(water2018.12$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.12$date, y = as.numeric(water2018.12$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.12$date, format(water2018.12$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

# env of site 13 =========== 
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T)

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = water2018.13$date, y = water2018.13$Temperature, axes = F, ylim = c(0, 20), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '13號樣站(一號壩下游)2018環境因子', family = "蘋方-繁 標準體", cex.main = 2)
points(x = water2018.13$date, y = water2018.13$Temperature, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 20), col = 'black', lwd = 2)
mtext(2, text = 'Temperature'~ (degree*C), line = 2)


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$DO), axes = F, ylim = c(0, 12), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$DO), pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 12), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = 'DO(mg/L)', line = 5.7)


# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$NO3_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$NO3_N), pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = 'NO3-N(mg/L)', line = 9.2)

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$NO2_N), axes = F, ylim = c(0, 6), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$NO2_N), pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 6), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = 'NO2-N(µg/L)', line = 12.7)

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = water2018.13$date, y = as.numeric(water2018.13$TOC), axes = F, ylim = c(0, 3), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = water2018.13$date, y = as.numeric(water2018.13$TOC), pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 3), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = 'TOC(mg/L)', line = 16.2)


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, water2018.13$date, format(water2018.13$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black',line = 2)

# And then plot the legend.
legend('bottomright', legend = c('Temperature', 'DO', 'NO3-N', 'NO2-N', 'TOC'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)



dev.off()


# species ===
# spe of site 9 ===========

# subset species data of site 9
algae2018.mean.9 <- algae2018.mean[algae2018.mean$id == '9', ]
amphibia2018.total.9 <- amphibia2018.total[amphibia2018.total$id == '9', ]
bird2018.total.9 <- bird2018.total[bird2018.total$id == '9', ]
fish2018.total.9 <- fish2018.total[fish2018.total$id == '9', ]
insect2018.total.9 <- insect2018.total[insect2018.total$id == '9', ]


# choose data I need

# algae2018.mean.9: ALL
# frog 
amphibia2018.total.9 <- amphibia2018.total.9[c(2, 4, 6), ]

# bird2018.total.9: !! No bird data

# fish櫻花鉤吻鮭: No data
# fish2018.total.9 <- fish2018.total.9[c(2, 4, 6), ]

# insect2018.total.9: ALL

# make the row number of each dataframe are all the same 
# empty <- data.frame("id" = '9', "date" = as.Date('2018-02-01'), "scientific_name" = NA, "total" = NA, "Project_id" = '10')
# fish2018.total.9 <- rbind.data.frame(empty, fish2018.total.9)

empty2 <- data.frame("id" = '9', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.9 <- rbind.data.frame(empty2, amphibia2018.total.9)

# empty3 <- data.frame("id" = '9', "date" = as.Date('2018-07-01'), "total" = NA, "Project_id" = '11')
# bird2018.total.9 <- rbind.data.frame(bird2018.total.9[1:2,], empty3, bird2018.total.9[3,])

# empty4 <- data.frame("id" = '9', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.9 <- rbind.data.frame(insect2018.total.9, empty4)
# 

# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])


# plotting 
# dev.new()
png('spe9.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.9$date), y = algae2018.mean.9$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '9號樣站(有勝溪)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.9$date), y = algae2018.mean.9$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.9$date, y = amphibia2018.total.9$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.9$date, y = amphibia2018.total.9$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# # Plot the third y-axis. Again the line parameter are both further increased.
# par(new = T)
# 
# plot(x = bird2018.total.9$date, y = bird2018.total.9$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
# points(x = bird2018.total.9$date, y = bird2018.total.9$total, pch = 17, col = '#4daf4a')
# axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
# mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# # Plot the fourth y-axis. Again the line parameter are both further increased.
# par(new = T)
# 
# plot(x = fish2018.total.9$date, y = fish2018.total.9$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
# points(x = fish2018.total.9$date, y = fish2018.total.9$total, pch = 15, col = '#984ea3')
# axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
# mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.9$date, y = insect2018.total.9$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.9$date, y = insect2018.total.9$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '流石蛾科總數', line = 9.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.9$date, format(amphibia2018.total.9$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# spe of site 2 ===========

# subset species data of site 2
algae2018.mean.2 <- algae2018.mean[algae2018.mean$id == '2', ]
amphibia2018.total.2 <- amphibia2018.total[amphibia2018.total$id == '2', ]
bird2018.total.2 <- bird2018.total[bird2018.total$id == '2', ]
fish2018.total.2 <- fish2018.total[fish2018.total$id == '2', ]
insect2018.total.2 <- insect2018.total[insect2018.total$id == '2', ]


# choose data I need

# algae2018.mean.2: ALL
# frog 
amphibia2018.total.2 <- amphibia2018.total.2[c(1, 3, 5), ]

# bird2018.total.2: ALL
# fish櫻花鉤吻鮭: ALL
# fish2018.total.2 <- fish2018.total.2[c(2, 4, 6), ]
# insect2018.total.2: ALL

# make the row number of each dataframe are all the same 
# empty <- data.frame("id" = '2', "date" = as.Date('2018-02-01'), "scientific_name" = NA, "total" = NA, "Project_id" = '10')
# fish2018.total.2 <- rbind.data.frame(empty, fish2018.total.2)

empty2 <- data.frame("id" = '2', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.2 <- rbind.data.frame(empty2, amphibia2018.total.2)

empty3.1 <- data.frame("id" = c('2', '2'), "date" = c(as.Date('2018-02-01'), as.Date('2018-04-01')), "total" = c(NA, NA), "Project_id" = c('11', '11'))
empty3 <- data.frame("id" = '2', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '11')
bird2018.total.2 <- rbind.data.frame(empty3.1, bird2018.total.2, empty3)

# empty4 <- data.frame("id" = '2', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.2 <- rbind.data.frame(insect2018.total.2, empty4)


# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])





# plotting 
# dev.new()
png('spe2.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.2$date), y = algae2018.mean.2$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '2號樣站(桃山西溪)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.2$date), y = algae2018.mean.2$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.2$date, y = amphibia2018.total.2$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.2$date, y = amphibia2018.total.2$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.2$date, y = bird2018.total.2$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.2$date, y = bird2018.total.2$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.2$date, y = fish2018.total.2$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.2$date, y = fish2018.total.2$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.2$date, y = insect2018.total.2$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.2$date, y = insect2018.total.2$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.2$date, format(amphibia2018.total.2$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# spe of site 3 ===========

# subset species data of site 3
algae2018.mean.3 <- algae2018.mean[algae2018.mean$id == '3', ]
amphibia2018.total.3 <- amphibia2018.total[amphibia2018.total$id == '3', ]
bird2018.total.3 <- bird2018.total[bird2018.total$id == '3', ]
fish2018.total.3 <- fish2018.total[fish2018.total$id == '3', ]
insect2018.total.3 <- insect2018.total[insect2018.total$id == '3', ]


# choose data I need

# algae2018.mean.3: ALL
# frog 
amphibia2018.total.3 <- amphibia2018.total.3[c(2, 4, 6), ]

# bird2018.total.3: ALL
bird2018.total.3 <- bird2018.total.3[-2, ]
# fish櫻花鉤吻鮭
fish2018.total.3 <- fish2018.total.3[c(1, 3, 5, 7), ]
# insect2018.total.3: ALL

# make the row number of each dataframe are all the same 
# empty <- data.frame("id" = '3', "date" = as.Date('2018-02-01'), "scientific_name" = NA, "total" = NA, "Project_id" = '10')
# fish2018.total.3 <- rbind.data.frame(empty, fish2018.total.3)

empty2 <- data.frame("id" = '3', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.3 <- rbind.data.frame(empty2, amphibia2018.total.3)

# empty3 <- data.frame("id" = '3', "date" = as.Date('2018-07-01'), "total" = NA, "Project_id" = '11')
# bird2018.total.3 <- rbind.data.frame(bird2018.total.3[1:2,], empty3, bird2018.total.3[3,])

# empty4 <- data.frame("id" = '3', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.3 <- rbind.data.frame(insect2018.total.3, empty4)
# 

# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])


# plotting 
# dev.new()
png('spe3.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.3$date), y = algae2018.mean.3$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '3號樣站(二號壩)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.3$date), y = algae2018.mean.3$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.3$date, y = amphibia2018.total.3$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.3$date, y = amphibia2018.total.3$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.3$date, y = bird2018.total.3$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.3$date, y = bird2018.total.3$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.3$date, y = fish2018.total.3$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.3$date, y = fish2018.total.3$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.3$date, y = insect2018.total.3$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.3$date, y = insect2018.total.3$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.3$date, format(amphibia2018.total.3$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()


# spe of site 4 ===========

# subset species data of site 4
algae2018.mean.4 <- algae2018.mean[algae2018.mean$id == '4', ]
amphibia2018.total.4 <- amphibia2018.total[amphibia2018.total$id == '4', ]
bird2018.total.4 <- bird2018.total[bird2018.total$id == '4', ]
fish2018.total.4 <- fish2018.total[fish2018.total$id == '4', ]
insect2018.total.4 <- insect2018.total[insect2018.total$id == '4', ]


# choose data I need

# algae2018.mean.4: ALL
# frog 
amphibia2018.total.4 <- amphibia2018.total.4[c(2, 4, 6), ]

# bird2018.total.4: ALL
bird2018.total.4 <- bird2018.total.4[-2, ]

# fish櫻花鉤吻鮭
fish2018.total.4 <- fish2018.total.4[c(1, 3, 5, 7), ]
# insect2018.total.4: ALL

# make the row number of each dataframe are all the same 
# empty <- data.frame("id" = '4', "date" = as.Date('2018-02-01'), "scientific_name" = NA, "total" = NA, "Project_id" = '10')
# fish2018.total.4 <- rbind.data.frame(empty, fish2018.total.4)

empty2 <- data.frame("id" = '4', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.4 <- rbind.data.frame(empty2, amphibia2018.total.4)

# empty3 <- data.frame("id" = '4', "date" = as.Date('2018-07-01'), "total" = NA, "Project_id" = '11')
# bird2018.total.4 <- rbind.data.frame(bird2018.total.4[1:2,], empty3, bird2018.total.4[3,])

# empty4 <- data.frame("id" = '4', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.4 <- rbind.data.frame(insect2018.total.4, empty4)
# 

# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])


# plotting 
# dev.new()
png('spe4.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.4$date), y = algae2018.mean.4$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '4號樣站(觀魚台)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.4$date), y = algae2018.mean.4$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.4$date, y = amphibia2018.total.4$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.4$date, y = amphibia2018.total.4$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.4$date, y = bird2018.total.4$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.4$date, y = bird2018.total.4$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.4$date, y = fish2018.total.4$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.4$date, y = fish2018.total.4$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.4$date, y = insect2018.total.4$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.4$date, y = insect2018.total.4$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.4$date, format(amphibia2018.total.4$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()

# spe of site 5 ===========

# subset species data of site 5
algae2018.mean.5 <- algae2018.mean[algae2018.mean$id == '5', ]
amphibia2018.total.5 <- amphibia2018.total[amphibia2018.total$id == '5', ]
bird2018.total.5 <- bird2018.total[bird2018.total$id == '5', ]
fish2018.total.5 <- fish2018.total[fish2018.total$id == '5', ]
insect2018.total.5 <- insect2018.total[insect2018.total$id == '5', ]


# choose data I need

# algae2018.mean.5: ALL
# frog 
amphibia2018.total.5 <- amphibia2018.total.5[c(2, 4, 6), ]

# bird2018.total.5: ALL
# fish櫻花鉤吻鮭
fish2018.total.5 <- fish2018.total.5[c(1, 3, 5, 7), ]
# insect2018.total.5: ALL

# make the row number of each dataframe are all the same 
# empty <- data.frame("id" = '5', "date" = as.Date('2018-02-01'), "scientific_name" = NA, "total" = NA, "Project_id" = '10')
# fish2018.total.5 <- rbind.data.frame(empty, fish2018.total.5)

empty2 <- data.frame("id" = '5', "date" = as.Date('2018-02-01'), "notes" = NA, "total" = NA, "Project_id" = '9')
amphibia2018.total.5 <- rbind.data.frame(empty2, amphibia2018.total.5)

# empty3 <- data.frame("id" = '5', "date" = as.Date('2018-07-01'), "total" = NA, "Project_id" = '11')
# bird2018.total.5 <- rbind.data.frame(bird2018.total.5[1:2,], empty3, bird2018.total.5[3,])

# empty4 <- data.frame("id" = '5', "date" = as.Date('2018-10-01'), "total" = NA, "Project_id" = '6')
# insect2018.total.5 <- rbind.data.frame(insect2018.total.5, empty4)
# 

# rbind(existingDF[1:r,],newrow,existingDF[-(1:r),])


# plotting 
# dev.new()
png('spe5.png', width = 36, height = 24, units = 'cm', res = 500)


par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.5$date), y = algae2018.mean.5$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '5號樣站(繁殖場)2018各子計畫', family = "蘋方-繁 標準體")
points(x = as.Date(algae2018.mean.5$date), y = algae2018.mean.5$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.5$date, y = amphibia2018.total.5$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.5$date, y = amphibia2018.total.5$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.5$date, y = bird2018.total.5$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.5$date, y = bird2018.total.5$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.5$date, y = fish2018.total.5$total, axes = F, ylim = c(0, 250), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.5$date, y = fish2018.total.5$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 250), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.5$date, y = insect2018.total.5$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.5$date, y = insect2018.total.5$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.5$date, format(amphibia2018.total.5$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)

dev.off()


# put the spe of all sites plots together into one big figure (1) ========
png('spe-allsites1.png', width = 36*2, height = 24*2, units = 'cm', res = 500)
par(mfrow = c(2, 2))

#
# spe of site 2 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.2$date), y = algae2018.mean.2$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '2號樣站(桃山西溪)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.2$date), y = algae2018.mean.2$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.2$date, y = amphibia2018.total.2$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.2$date, y = amphibia2018.total.2$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.2$date, y = bird2018.total.2$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.2$date, y = bird2018.total.2$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.2$date, y = fish2018.total.2$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.2$date, y = fish2018.total.2$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.2$date, y = insect2018.total.2$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.2$date, y = insect2018.total.2$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.2$date, format(amphibia2018.total.2$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)


# spe of site 3 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.3$date), y = algae2018.mean.3$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '3號樣站(二號壩)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.3$date), y = algae2018.mean.3$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.3$date, y = amphibia2018.total.3$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.3$date, y = amphibia2018.total.3$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.3$date, y = bird2018.total.3$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.3$date, y = bird2018.total.3$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.3$date, y = fish2018.total.3$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.3$date, y = fish2018.total.3$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.3$date, y = insect2018.total.3$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.3$date, y = insect2018.total.3$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.3$date, format(amphibia2018.total.3$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)



# spe of site 4 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.4$date), y = algae2018.mean.4$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '4號樣站(觀魚台)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.4$date), y = algae2018.mean.4$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.4$date, y = amphibia2018.total.4$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.4$date, y = amphibia2018.total.4$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.4$date, y = bird2018.total.4$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.4$date, y = bird2018.total.4$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.4$date, y = fish2018.total.4$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.4$date, y = fish2018.total.4$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.4$date, y = insect2018.total.4$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.4$date, y = insect2018.total.4$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.4$date, format(amphibia2018.total.4$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)


# spe of site 5 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.5$date), y = algae2018.mean.5$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '5號樣站(繁殖場)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.5$date), y = algae2018.mean.5$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.5$date, y = amphibia2018.total.5$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.5$date, y = amphibia2018.total.5$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.5$date, y = bird2018.total.5$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.5$date, y = bird2018.total.5$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.5$date, y = fish2018.total.5$total, axes = F, ylim = c(0, 250), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.5$date, y = fish2018.total.5$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 250), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.5$date, y = insect2018.total.5$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.5$date, y = insect2018.total.5$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.5$date, format(amphibia2018.total.5$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)


dev.off()


# put the spe of all sites plots together into one big figure (2) ========
png('spe-allsites2.png', width = 36*2, height = 24*2, units = 'cm', res = 500)
par(mfrow = c(2, 2))

#
# spe of site 8 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.8$date), y = algae2018.mean.8$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '8號樣站(高山溪)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.8$date), y = algae2018.mean.8$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.8$date, y = amphibia2018.total.8$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.8$date, y = amphibia2018.total.8$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")


# # Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.8$date, y = bird2018.total.8$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.8$date, y = bird2018.total.8$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.8$date, y = fish2018.total.8$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.8$date, y = fish2018.total.8$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.8$date, y = insect2018.total.8$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.8$date, y = insect2018.total.8$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.8$date, format(amphibia2018.total.8$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類','鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)



# spe of site 9 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.9$date), y = algae2018.mean.9$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '9號樣站(有勝溪)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.9$date), y = algae2018.mean.9$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.9$date, y = amphibia2018.total.9$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.9$date, y = amphibia2018.total.9$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# # Plot the third y-axis. Again the line parameter are both further increased.
# par(new = T)
# 
# plot(x = bird2018.total.9$date, y = bird2018.total.9$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
# points(x = bird2018.total.9$date, y = bird2018.total.9$total, pch = 17, col = '#4daf4a')
# axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
# mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# # Plot the fourth y-axis. Again the line parameter are both further increased.
# par(new = T)
# 
# plot(x = fish2018.total.9$date, y = fish2018.total.9$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
# points(x = fish2018.total.9$date, y = fish2018.total.9$total, pch = 15, col = '#984ea3')
# axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
# mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.9$date, y = insect2018.total.9$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.9$date, y = insect2018.total.9$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '流石蛾科總數', line = 9.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.9$date, format(amphibia2018.total.9$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)



# spe of site 12 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.12$date), y = algae2018.mean.12$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '12號樣站(一號壩上游)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.12$date), y = algae2018.mean.12$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.12$date, y = amphibia2018.total.12$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.12$date, y = amphibia2018.total.12$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.12$date, y = bird2018.total.12$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.12$date, y = bird2018.total.12$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.12$date, y = fish2018.total.12$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.12$date, y = fish2018.total.12$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.12$date, y = insect2018.total.12$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.12$date, y = insect2018.total.12$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.12$date, format(amphibia2018.total.12$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)



# spe of site 13 ===========
par(mar = c(5, 18, 4, 4) + 0.1, xpd = T, family = "蘋方-繁 標準體")

# Plot the first y-axis. Notice that you don’t have to draw the axis nor the labels
plot(x = as.Date(algae2018.mean.13$date), y = algae2018.mean.13$mean.bio, axes = F, ylim = c(0, 80), xlab = '', ylab = '', type = 'l', col = '#e41a1c', main = '13號樣站(一號壩下游)2018各子計畫', family = "蘋方-繁 標準體", cex.main = 2)
points(x = as.Date(algae2018.mean.13$date), y = algae2018.mean.13$mean.bio, pch = 20, col = '#e41a1c')
axis(2, ylim = c(0, 80), col = 'black', lwd = 2)
mtext(2, text = '平均葉綠素a濃度', line = 2, family = "蘋方-繁 標準體")


# Plot the second y-axis. The command par(new=T) is handy here. Notice that in both functions lines is increased so that the new axis and its label is placed to the left of the first one. 
par(new = T)

plot(x = amphibia2018.total.13$date, y = amphibia2018.total.13$total, axes = F, ylim = c(0, 85), xlab = '', ylab = '', type = 'l', col = '#377eb8', main = '')
points(x = amphibia2018.total.13$date, y = amphibia2018.total.13$total, pch = 18, col = '#377eb8')
axis(2, ylim = c(0, 85), col = 'black', lwd = 2, line = 3.7)
mtext(2, text = '成蛙總數', line = 5.7, family = "蘋方-繁 標準體")

# Plot the third y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = bird2018.total.13$date, y = bird2018.total.13$total, axes = F, ylim = c(0, 7), xlab = '', ylab = '', type = 'l', col = '#4daf4a', main = '')
points(x = bird2018.total.13$date, y = bird2018.total.13$total, pch = 17, col = '#4daf4a')
axis(2, ylim = c(0, 7), col = 'black', lwd = 2, line = 7.2)
mtext(2, text = '河烏總數', line = 9.2, family = "蘋方-繁 標準體")

# Plot the fourth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = fish2018.total.13$date, y = fish2018.total.13$total, axes = F, ylim = c(0, 60), xlab = '', ylab = '', type = 'l', col = '#984ea3', main = '')
points(x = fish2018.total.13$date, y = fish2018.total.13$total, pch = 15, col = '#984ea3')
axis(2, ylim = c(0, 60), col = 'black', lwd = 2, line = 10.7)
mtext(2, text = '台灣櫻花鉤吻鮭總數', line = 12.7, family = "蘋方-繁 標準體")

# Plot the fifth y-axis. Again the line parameter are both further increased.
par(new = T)

plot(x = insect2018.total.13$date, y = insect2018.total.13$total, axes = F, ylim = c(0, 90), xlab = '', ylab = '', type = 'l', col = '#ff7f00', main = '')
points(x = insect2018.total.13$date, y = insect2018.total.13$total, pch = 1, col = '#ff7f00')
axis(2, ylim = c(0, 90), col = 'black', lwd = 2, line = 14.2)
mtext(2, text = '流石蛾科總數', line = 16.2, family = "蘋方-繁 標準體")


# draw the X-axis, which is of course shared by all the y-axis.
axis(1, amphibia2018.total.13$date, format(amphibia2018.total.13$date, "%b"), cex.axis = .7)
mtext('date', side = 1, col = 'black', line = 2)

# And then plot the legend.
legend('bottomright', legend = c('藻類', '兩生類', '鳥類', '魚類', '水棲昆蟲'),pch = c(20, 18, 17, 15, 1), col = c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00'), bty = 'n', xpd = T, y.intersp = 0.8, x.intersp = 0.7)


dev.off()


