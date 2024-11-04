%% SA Score Distribution
data_path = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data';
load(fullfile(data_path,'raw_sa_scores.mat'));
load(fullfile(data_path,'adj_sa_scores.mat'));

adj_sa_scores(:,:,4) = adj_sa_scores(:,:,1)...
                       + adj_sa_scores(:,:,2)...
                       + adj_sa_scores(:,:,3);

for i = 1:4
    mean_level_sa = normalize(mean(adj_sa_scores(:,:,i),2,'omitmissing'));
    mean_level_sa = mean(adj_sa_scores(:,:,i),2,'omitmissing');
    fig = figure;
    histogram(mean_level_sa);
    [H, p, D, cV] = kstest(mean_level_sa);
    if H
        str = sprintf("Not normally distributed.\n" + ...
            "D(%d) = %0.2f, p = %0.2f.",height(mean_level_sa), D, p);
    else
        str = sprintf("Normally distributed.\n" + ...
            "D(%d) = %0.2f, p = %0.2f.",height(mean_level_sa), D, p);
    end
    annotation(fig,"textbox",[0.15,0.7,0.1,0.1],"String",str);
    if i < 4
        title(sprintf('Mean Level %d SA',i));
        saveas(fig,sprintf('Level_%d_SA_Distribution_%d_subs.jpg',i, ...
            height(adj_sa_scores(:,:,i))))
    else
        title('Mean Total SA');
        saveas(fig,sprintf('Total_SA_Distribution_%d_subs.jpg',i, ...
            height(adj_sa_scores(:,:,i))))
    end
end
