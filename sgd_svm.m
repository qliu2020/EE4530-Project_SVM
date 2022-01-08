function [true_W,b]=sgd_svm(X,Y,param)  

iterations=param.iterations;%10  
lambda=param.lambda;%1e-3 
biaScale=param.biaScale;%0 
t0=param.t0;%100  
t=t0;
  
w=zeros(1,size(X,2));  
bias=0;  
  
for k=1:1:iterations  
    for i=1:1:size(X,1)  
        t=t+1;  
        alpha = (1.0/(lambda*t));  
        if(Y(i)*(X(i,:)*w'+bias)<1)  
            bias=bias+alpha*Y(i)*biaScale;  
            w=w+alpha*Y(i,1).*X(i,:);  
        end  
    end  
end  
b=bias;  
true_W=w;