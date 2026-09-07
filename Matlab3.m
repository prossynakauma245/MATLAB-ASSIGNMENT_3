clc;
clear;
close all;

%% READ EXCEL FILE
T = readtable('C:\Users\user\Desktop\GROUP\APE GROUP1.xlsx','VariableNamingRule','preserve');

AGE         = T.AGE;
SIBLINGS    = T.NO_OFSIBLINGS;
GENDER      = categorical(string(T.GENDER));
TRIBE       = categorical(string(T.TRIBE));
ASSOCIATION = categorical(string(T.ASSOCIATION));
HOSTEL      = categorical(string(T.HOSTEL_HALL));
HOBBIES     = categorical(string(T.HOBBIES));

STUDENT_NO = (1:height(T))';

% Folder for saving plots
if ~exist('MATLAB_PLOTS','dir')
    mkdir('MATLAB_PLOTS');
end
%% 1.LINE PLOT
figure;
plot(STUDENT_NO,AGE,'-o','LineWidth',1.5);
xlabel('Student Number');
ylabel('Age');
title('Line Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/01_Line_Plot.png');
savefig(gcf,'MATLAB_PLOTS/01_Line_Plot.fig');
close;
%% 2.SCATTER PLOT
valid = ~isnan(AGE) & ~isnan(SIBLINGS);

figure;
scatter(AGE(valid),SIBLINGS(valid),50,'filled');
xlabel('Age');
ylabel('Number of Siblings');
title('Scatter Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/02_Scatter_Plot.png');
savefig(gcf,'MATLAB_PLOTS/02_Scatter_Plot.fig');
close;
%% 3.BAR GRAPH
[g,~,id] = unique(GENDER);
count = accumarray(id,1);

figure;
bar(count);
set(gca,'XTick',1:length(g), ...
    'XTickLabel',cellstr(g));
xlabel('Gender');
ylabel('Number of Students');
title('Bar Graph');
grid on;
saveas(gcf,'MATLAB_PLOTS/03_Bar_Graph.png');
savefig(gcf,'MATLAB_PLOTS/03_Bar_Graph.fig');
close;
%% 4.HORIZONTAL BAR GRAPH
[t,~,id] = unique(TRIBE);
count = accumarray(id,1);

figure;
barh(count);
set(gca,'YTick',1:length(t), ...
    'YTickLabel',cellstr(t));
xlabel('Number of Students');
ylabel('Tribe');
title('Horizontal Bar Graph');
grid on;
saveas(gcf,'MATLAB_PLOTS/04_Horizontal_Bar_Graph.png');
savefig(gcf,'MATLAB_PLOTS/04_Horizontal_Bar_Graph.fig');
close;

%% 6. STEM PLOT
valid = ~isnan(SIBLINGS);
figure;
stem(STUDENT_NO(valid),SIBLINGS(valid),'filled');
xlabel('Student Number');
ylabel('Number of Siblings');
title('Stem Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/06_Stem_Plot.png');
savefig(gcf,'MATLAB_PLOTS/06_Stem_Plot.fig');
close;
%% 7.STEP PLOT
valid = ~isnan(AGE);

figure;
stairs(STUDENT_NO(valid),AGE(valid),'LineWidth',1.5);
xlabel('Student Number');
ylabel('Age');
title('Step Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/07_Step_Plot.png');
savefig(gcf,'MATLAB_PLOTS/07_Step_Plot.fig');
close;


%% 8.ERROR BAR PLOT
[g,~,id] = unique(GENDER);

meanAge = zeros(length(g),1);
stdAge  = zeros(length(g),1);

for i = 1:length(g)
    x = AGE(id == i);
    x = x(~isnan(x));
    meanAge(i) = mean(x);
    stdAge(i) = std(x);
end

figure;
errorbar(1:length(g),meanAge,stdAge,'o','LineWidth',1.5);

set(gca,'XTick',1:length(g), ...
    'XTickLabel',cellstr(g));

xlabel('Gender');
ylabel('Mean Age');
title('Error Bar Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/08_Error_Bar_Plot.png');
savefig(gcf,'MATLAB_PLOTS/08_Error_Bar_Plot.fig');
close;


%% 9. AREA PLOT
valid = ~isnan(AGE);

figure;
area(STUDENT_NO(valid),AGE(valid));
xlabel('Student Number');
ylabel('Age');
title('Area Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/09_Area_Plot.png');
savefig(gcf,'MATLAB_PLOTS/09_Area_Plot.fig');
close;


%% 10. HISTOGRAM
valid = ~isnan(AGE);

figure;
histogram(AGE(valid));
xlabel('Age');
ylabel('Frequency');
title('Histogram');
grid on;
saveas(gcf,'MATLAB_PLOTS/10_Histogram.png');
savefig(gcf,'MATLAB_PLOTS/10_Histogram.fig');
close;


%% 11. PARETO CHART
[h,~,id] = unique(HOBBIES);
count = accumarray(id,1);

[count,order] = sort(count,'descend');
h = h(order);

figure;
pareto(count,cellstr(h));
xlabel('Hobbies');
ylabel('Number of Students');
title('Pareto Chart');
grid on;
saveas(gcf,'MATLAB_PLOTS/11_Pareto_Chart.png');
savefig(gcf,'MATLAB_PLOTS/11_Pareto_Chart.fig');
close;


%% 12. BOX PLOT
valid = ~isnan(AGE);

figure;
boxplot(AGE(valid),GENDER(valid));
xlabel('Gender');
ylabel('Age');
title('Box Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/12_Box_Plot.png');
savefig(gcf,'MATLAB_PLOTS/12_Box_Plot.fig');
close;


%% 13. PIE CHART
[g,~,id] = unique(GENDER);
count = accumarray(id,1);

figure;
pie(count);
legend(cellstr(g),'Location','bestoutside');
title('Pie Chart');
saveas(gcf,'MATLAB_PLOTS/13_Pie_Chart.png');
savefig(gcf,'MATLAB_PLOTS/13_Pie_Chart.fig');
close;


%% 14. PIE CHART WITH PERCENT LABELS
[g,~,id] = unique(GENDER);
count = accumarray(id,1);

percentage = (count/sum(count))*100;

labels = strings(length(g),1);

for i = 1:length(g)
    labels(i) = sprintf('%s = %.1f%%', ...
        string(g(i)),percentage(i));
end

figure;
pie(count);
legend(cellstr(labels),'Location','bestoutside');
title('Pie Chart with Percentage Labels');

saveas(gcf,'MATLAB_PLOTS/14_Pie_Chart_Percentage.png');
savefig(gcf,'MATLAB_PLOTS/14_Pie_Chart_Percentage.fig');
close;


%% 15. LOGARITHMIC PLOTS

%  SEMILOG-X
valid = ~isnan(AGE) & STUDENT_NO > 0 & AGE > 0;

figure;
semilogx(STUDENT_NO(valid),AGE(valid),'-o','LineWidth',1.5);
xlabel('Student Number');
ylabel('Age');
title('Semilog-X Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/15a_SemilogX.png');
savefig(gcf,'MATLAB_PLOTS/15a_SemilogX.fig');
close;


% 16. SEMILOG-Y
valid = ~isnan(SIBLINGS) & ...
        STUDENT_NO > 0 & ...
        SIBLINGS > 0;

figure;
semilogy(STUDENT_NO(valid),SIBLINGS(valid),'-o','LineWidth',1.5);
xlabel('Student Number');
ylabel('Number of Siblings');
title('Semilog-Y Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/15b_SemilogY.png');
savefig(gcf,'MATLAB_PLOTS/15b_SemilogY.fig');
close;


% 17. LOG-LOG
valid = ~isnan(AGE) & ...
        ~isnan(SIBLINGS) & ...
        AGE > 0 & ...
        SIBLINGS > 0;

figure;
loglog(AGE(valid),SIBLINGS(valid),'o','MarkerSize',7);
xlabel('Age');
ylabel('Number of Siblings');
title('Log-Log Plot');
grid on;
saveas(gcf,'MATLAB_PLOTS/15c_LogLog.png');
savefig(gcf,'MATLAB_PLOTS/15c_LogLog.fig');
close;