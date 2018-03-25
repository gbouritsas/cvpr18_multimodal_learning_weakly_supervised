movies={'DEP','LOR','BMI','CRA','GLA'}; coordinate='action';
global movies_folder;movies_folder = '../movies/';
global categories_folder;categories_folder='../manual_annotation';
global categories_extended_file;categories_extended_file='/categories_ids.mat';
global categories_small_file;categories_small_file='/categories_ids_47.mat';
global mosek_path; mosek_path = '~/Documents/mosek/8/toolbox/r2014aom';

%incorporate prior information if available
global v;v=0; global weight_choice; weight_choice='equal';
global label_set; label_set='closed'; global optflag; optflag='min';

fps=25;fps_weird=24.9997500025000;
global alpha;alpha=2;
global kapa;kapa=1;
global lambda;lambda=0.000001;

% The method according to which the frequency of classes is calculated
global method_of_classes;method_of_classes='ground truth';

global bg_concept;bg_concept=false;
global external_background;external_background=false;
global alpha_2;alpha_2=0.5;

global similarity_method; similarity_method='wordnet';


kernel={'linear_c3d','chisquared_c3d','linear_trajectories','chisquared_trajectories'};
localization={'manual localization', 'facetrack localization'};
label_method={'maximum','weighted_instances','weighted_slacks'};
similarity_threshold=0:0.1:1;
membership_function={'linear','step','concave_pchip','convex_pchip','normalize','gamma_sigmoid','gamma_linear','gamma_rational','gamma_s','gamma_cubic','gamma_pchip'};
membership_threshold={1,0:0.1:1,[0.01 0.1:0.1:0.8],[0.2:0.1:0.9 0.99],1,0:0.1:1,0:0.1:1,0:0.1:1,0:0.1:1,0:0.1:1,0:0.1:1};
membership_k={0,0,0,0,0,5:5:30,0,1000:2000:10000,0:0.1:1,0:0.1:1,0:0.1:1};
extend=0:10:150;


%%
% accuracy=zeros(6,5,5);
optflag='feas';
hwait=waitbar(0,'Please wait...');
for k=2:2:10
    for j=1:length(movies)
        movie_name=movies{j};
        return_code=prepare_for_opt_action({movie_name}, similarity_threshold(end), label_method(1),...
                    membership_function(2), membership_threshold{2}(1), 0,...
                    k, extend(1), kernel(1), localization(1), fps, fps_weird);
        if return_code(1)==0
            datapath = [movies_folder movie_name '/results_optimization/data_new_experiment.mat'];
            load(datapath);
            Z=randi(max(GTa),[length(GTa),1]);
            Y=sparse(1:length(GTa),GTa,1);
            Z=sparse(1:length(Z),Z,1);
            result=evaluate(Z, Y,[]);
            accuracy(1,k/2,j)=result.ap;
        else
            main;
            accuracy(1,k/2,j)=result{1,1}.ap;
        end
    end
    waitbar(k/10)
end
close(hwait)

optflag='min';
hwait=waitbar(0,'Please wait...');

for k=2:2:10
    for j=1:length(movies)
        movie_name=movies{j};   
        return_code=prepare_for_opt_action({movie_name}, similarity_threshold(end), label_method(1),...
                    membership_function(2),membership_threshold{2}(1), 0,...
                    k, extend(1), kernel(1), localization(1), fps, fps_weird);
        if return_code(1)==0
            datapath = [movies_folder movie_name '/results_optimization/data_new_experiment.mat'];
            load(datapath);
            randint = randi(max(GTa));
            Z=randint*ones(length(GTa),1);
            Y=sparse(1:length(GTa),GTa,1);
            Z=sparse(1:length(Z),Z,1);
            result=evaluate(Z, Y,[]);
            accuracy(2,k/2,j)=result.ap;
        else
            main;
            accuracy(2,k/2,j)=result{1,1}.ap;
        end
    end
    waitbar(k/10)
end
close(hwait)

hwait=waitbar(0,'Please wait...');
for k=2:2:10
    for j=1:length(movies)
        movie_name=movies{j};   
        return_code=prepare_for_opt_action({movie_name}, 0.4, label_method(1),...
                    membership_function(2), membership_threshold{2}(1), 0,...
                    k, extend(1), kernel(1), localization(1), fps, fps_weird);
        if return_code(1)==0
            datapath = [movies_folder movie_name '/results_optimization/data_new_experiment.mat'];
            load(datapath);
            randint = randi(max(GTa));
            Z=randint*ones(length(GTa),1);
            Y=sparse(1:length(GTa),GTa,1);
            Z=sparse(1:length(Z),Z,1);
            result=evaluate(Z, Y,[]);
            accuracy(3,k/2,j)=result.ap;
        else
            main;
            accuracy(3, k/2, j)=result{1,1}.ap;
        end
    end
    waitbar(k/10)
end
close(hwait)

hwait=waitbar(0,'Please wait...');
for k=2:2:10
    for j=1:length(movies)
        movie_name=movies{j};   
        return_code=prepare_for_opt_action({movie_name}, 0.4, label_method(3),...
                    membership_function(2), membership_threshold{2}(1), 0,...
                    k, extend(1), kernel(1),localization(1),fps,fps_weird);
        if return_code(1)==0
            datapath = [movies_folder movie_name '/results_optimization/data_new_experiment.mat'];
            load(datapath);
            randint = randi(max(GTa));
            Z=randint*ones(length(GTa),1);
            Y=sparse(1:length(GTa),GTa,1);
            Z=sparse(1:length(Z),Z,1);
            result=evaluate(Z, Y,[]);
            accuracy(4,k/2,j)=result.ap;
        else
            main;
            accuracy(4,k/2,j)=result{1,1}.ap;
        end
    end
    waitbar(k/10)
end
close(hwait)

hwait=waitbar(0,'Please wait...');
for k=2:2:10
    for j=1:length(movies)
        movie_name=movies{j};   
        return_code=prepare_for_opt_action({movie_name}, 0.4, label_method(1),...
                    membership_function(8),membership_threshold{8}(2),membership_k{8}(3),...
                    k, extend(11), kernel(1), localization(1), fps, fps_weird);
        if return_code(1)==0
            datapath = [movies_folder movie_name '/results_optimization/data_new_experiment.mat'];
            load(datapath);
            randint = randi(max(GTa));
            Z=randint*ones(length(GTa),1);
            Y=sparse(1:length(GTa),GTa,1);
            Z=sparse(1:length(Z),Z,1);
            result=evaluate(Z, Y,[]);
            accuracy(5,k/2,j)=result.ap;
        else
            main;
            accuracy(5, k/2, j)=result{1,1}.ap;
        end
    end
    waitbar(k/10)
end
close(hwait)

hwait=waitbar(0,'Please wait...');
for k=2:2:10
    for j=1:length(movies)
        movie_name=movies{j};   
        return_code=prepare_for_opt_action({movie_name}, 0.4, label_method(3),...
                    membership_function(8),membership_threshold{8}(2),membership_k{8}(3),...
                    k, extend(11), kernel(1), localization(1), fps, fps_weird);
        if return_code(1)==0
            datapath = [movies_folder movie_name '/results_optimization/data_new_experiment.mat'];
            load(datapath);
            randint = randi(max(GTa));
            Z=randint*ones(length(GTa),1);
            Y=sparse(1:length(GTa),GTa,1);
            Z=sparse(1:length(Z),Z,1);
            result=evaluate(Z, Y,[]);
            accuracy(6,k/2,j)=result.ap;
        else
            main;
            accuracy(6, k/2, j)=result{1,1}.ap;
        end
    end
    waitbar(k/10)
end
close(hwait)

