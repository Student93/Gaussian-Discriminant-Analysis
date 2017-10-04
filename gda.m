syms X
X = importdata('q4x.dat');
yTemp = importdata('q4y.dat');
n = 2;
m = size(yTemp,1);
%Alaska 0 
for i= 1:m
    if strcmp(yTemp(i), 'Alaska')
        Y(i) = 0;
    end
    if strcmp(yTemp(i), 'Canada')
        Y(i) = 1;
    end
end
Y = Y' ;
u0 = zeros(n, 1);
u1 = zeros(n, 1);
count0 = 0;
for i = 1:m
    if Y(i) == 0
        u0 = u0 + X(i,:)';
        count0 = count0 + 1;
    end
    if Y(i) == 1
        u1 = u1 + X(i,:)';
    end
        
end

u0 = u0 / count0;
u1 = u1 / (m-count0);

sigma = zeros(n, n);

for i = 1:m
    temp = zeros(n,1);
    if Y(i) == 0
       temp =  X(i,:)' - u0;
    end
    if Y(i) ==  1
       temp = X(i,:)' - u1;
    end
        
    sigma = sigma + temp * temp';
        
end
 
sigma = sigma / m;

% 2nd part
a = 20;
xA=0;
xC=0;
countA=1;
countC=1;
figure
for i=1:m
    if Y(i) == 0
        %scatter(X(i,1),X(i,2),a, 'MarkerEdgeColor',[0 .5 .5],...
        %'MarkerFaceColor',[0 .7 .7],...
        %'LineWidth',1.5);
        xA(countA,1)=X(i,1);
        xA(countA,2)=X(i,2);
        countA = countA + 1;
    end
    if Y(i) == 1
        %scatter(X(i,1),X(i,2),a, 'MarkerEdgeColor',[0 0.2 0.2],...
        %'MarkerFaceColor',[0 .2 .2],...
        %'LineWidth',1.5);
        xC(countC,1)=X(i,1);
        xC(countC,2)=X(i,2);
        countC = countC + 1;
    end
    hold on;
end

plot(xA(:,1), xA(:,2),'r+',xC(:,1), xC(:,2),'bo');
legend('Alaska','Canada')
%xlabel('Growth Ring Diameters in Fresh Water')
%ylabel('Growth Ring Diameters in Marine Water')
%title('Gaussian Discriminant Analysis')

%4th part

sigma0 = zeros(n,n);
sigma1 = zeros(n,n);
temp1 = zeros(n,1);


for i= 1:m
    temp1 = zeros(n,1);
    if Y(i) == 0
        temp1 = X(i,:)' - u0;
        sigma0 = sigma0 + temp1 * temp1';
    end
    if Y(i) == 1
        temp1 = X(i,:)' - u1;
        sigma1 = sigma1 + temp1 * temp1';
    end
end
sigma0 = sigma0/count0;
sigma1 = sigma1/(m-count0);
count1= m - count0;
phi = count1/m;
t = zeros(n,1);
t = ((( u0' * pinv(sigma)) - (u1' * inv(sigma))));
theta0 = (-0.5) * ((u0' * pinv(sigma) * u0) - (u1' * pinv(sigma) * u1)) + log((1-phi)/phi);

yToDraw = (-theta0 - t(1,1)*X(:,1))/t(1,2);
plot(X(:,1),yToDraw);



quadraticTerm = @(x,y) (-0.5)*([x y]*pinv(sigma0)*[x;y] - [x y]*pinv(sigma1)*[x;y]);
linearTerm = @(x,y) ((( u0' * pinv(sigma0)) - (u1' * inv(sigma1)))) * [x;y];
constTerm = (-0.5) * ((u0' * pinv(sigma0) * u0) - (u1' * pinv(sigma1) * u1)) + log((1-phi)/phi);
syms x1 y1;
f= quadraticTerm(x1,y1) + linearTerm(x1,y1)+ constTerm;
ezplot(f,[min(X(:,1)),max(X(:,1)),min(X(:,2)),max(X(:,2))]);
hold off;    

    










        
    
    
