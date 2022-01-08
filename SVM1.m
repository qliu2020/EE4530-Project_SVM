clear all;
clc;

%load data
load('linear_svm.mat');

%data preprocessing
A=[X_train,labels_train];
B=[3.68387000434281,2.78847576248854,1];
C=[0.103271486285735,3.91258335668248,-1];
D=[X_test,labels_test];
E=[2.02674250585341,0.490682197963205,1];
F=[1.53934416991628,2.97735953655902,-1];
for i=3:100
    if A(i,3)==1
        B=[B;A(i,:)];
    else
        C=[C;A(i,:)];
    end
end
for i=3:900
    if D(i,3)==1
        E=[E;D(i,:)];
    else
        F=[F;D(i,:)];
    end
end

%CVX solver
n=2;
tic;
cvx_begin
    variable w(n);
    variable b;
    minimize( 1/2*norm(w) );
    subject to
        labels_train.*( X_train * w + b) -1 >= 0;
cvx_end
toc;

%confusion matrix
TP=0;
FP=0;
FN=0;
TN=0;
for i=1:900
    if D(i,3)==1
        if (X_test(i,:) * w + b)> 0
            TP=TP+1;
        else
            FP=FP+1;
        end
    end
    if D(i,3)==-1;
        if (X_test(i,:) * w + b)< 0
            FN=FN+1;
        else
            TN=TN+1;
        end
    end
end
confusion_matrix=[TP,TN;FP,FN];
confusion_matrix

%plot the results
x=0:0.1:4;
y=-(w(1))/(w(2))*x-b/w(2);
scatter(B(:,1),B(:,2)','r','linewidth',1.5);
hold on;
scatter(C(:,1),C(:,2)','b','linewidth',1.5);
hold on;
scatter(E(:,1),E(:,2)','k','linewidth',1.5);
hold on;
scatter(F(:,1),F(:,2)','h','linewidth',1.5);
hold on;
plot(x,y,'g','linewidth',1.5);
axis([0 4 0 4]);








