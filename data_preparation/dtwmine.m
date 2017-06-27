%{
clear all;close all;clc;
t=[71 73 75 80 80 80 78 76 75 73 71 71 71 73 75 76 76 68 76 76 75 73 71 70 70 69 68 68 72 74 78 79 80 80 78];
r=[69 69 73 75 79 80 79 78 76 73 72 71 70 70 69 69 69 71 73 75 76 76 76 76 76 75 73 71 70 70 71 73 75 80 80 80 78];
pflag=1;
%size(a)
%size(b)
%}
% r=[1 2 3;4 5 6;7 6 5;22 1 2]';
% t=[11 2 33;5 4 4;3 33 3;9 0 9;1 1 2;3 4 5]';
%t=[1 2 3;4 5 6;7 6 5;22 1 2]';
function [Dist,D,k,w,rw,tw]=dtwmine(r,t,pflag,sim_measure);
% sim_measure=1 if simalarity measure is Euclidian distance
% sim_measure=0 if simalarity measure is angle between the vectors
% [Dist,D,k,w,rw,tw]=dtw(r,t,pflag)
%
% Dynamic Time Warping Algorithm
% Dist is unnormalized distance between t and r
% D is the accumulated distance matrix
% k is the normalizing factor
% w is the optimal path
% t is the vector you are testing against
% r is the vector you are testing
% rw is the warped r vector
% tw is the warped t vector
% pflag  plot flag: 1 (yes), 0(no)

%pflag=1;
%t=[71 73 75 80 80 80 78 76 75 73 71 71 71 73 75 76 76 68 76 76 75 73 71 70 70 69 68 68 72 74 78 79 80 80 78];
%r=[71 73 75 80 80 80 78 76 75 73 71 71 71 73 75 76 76 68 76 76 75 73 71 70 70 69 68 68 72 74 78 79 80 80 78];
%sim_measure=1;
%r=[69 69 73 75 79 80 79 78 76 73 72 71 70 70 69 69 69 71 73 75 76 76 76 76 76 75 73 71 70 70 71 73 75 80 80 80 78];
%  t=[1 1 2 2];% signal 2 in fig
%  r=[1 2 3 3 4];% signal 1 in fig
%  sim_measure=1;pflag=1;
%r=[1 1 1 2 3 3 4 4 4 5 5 7 7 7 8];
% if r and t are vectos
%[row,M]=size(r); if (row > M) M=row; r=r'; end;%in case r is column vector make it row vector
%[row,N]=size(t); if (row > N) N=row; t=t'; end;%in case t is column vector make it row vector
%d=(repmat(r',1,N)-repmat(t,M,1)).^2; 

% IF r and t are matrices find the distance matrix assuming each coloumn is
% a feature vector
[rowr M]=size(r);
[rowt N]=size(t);
d=zeros(M,N);
if sim_measure==1
for m=1:M
    rr=repmat(r(:,m),1,N);
    d(m,:)=sqrt(sum((rr-t).^2));% euclidian distance 
    
end
else
Er=sqrt(sum(r.^2));
Et=sqrt(sum(t.^2));
d=(r'*t)/(Er'*Et);% angle
end


% r=[r1 r2 .....rM];t=[t1 t2 ..... tN];
%           |r1-t1 r1-t2 ......r1-tN|      
%           |r2-t1 r2-t2 ......r1-tN|   
% Then d =  |.......................|
%           |rM-t1 rM-t2.......rM-tN|
%disp('distance matrix');
%d

D=zeros(size(d));

D(1,1)=d(1,1);

for m=2:M
    D(m,1)=d(m,1)+D(m-1,1);% the Y axis is reference signal m is the indexing along Y axis from top left corner downward to bottom left corner(as we do in case of matrix)
end
for n=2:N
    D(1,n)=d(1,n)+D(1,n-1);% the X axis is test signal n is the indexing along X axis from top left corner rightward to top right corner(as we do in case of matrix) 
end
for m=2:M
    for n=2:N
        D(m,n)=d(m,n)+min(D(m-1,n),min(D(m-1,n-1),D(m,n-1))); % this double MIn construction improves in 10-fold the Speed-up.
    end
end
% D is accumulated matrix next step is trace back to get (n,m) warping
% coordinates
Dist=D(M,N);
%disp('Accumulated distance matrix');
%D
n=N;
m=M;
k=1;
w=[M N];
while ((n+m)~=2)
    if (n-1)==0
        m=m-1;
    elseif (m-1)==0
        n=n-1;
    else 
      [values,number]=min([D(m-1,n-1),D(m-1,n),D(m,n-1)]);
      switch number
      case 1
        m=m-1;
        n=n-1;
      case 2
        m=m-1;
      case 3
        n=n-1;
      end
   end
    k=k+1;
    w=[m n; w]; 
end
%display('warped coordinates');
%w
% warped waves
rw=r(:,w(:,1));
tw=t(:,w(:,2));
 rw1=(sqrt(sum(rw.^2)));%just for plotting purpose
 tw1=(sqrt(sum(tw.^2)));%just for plotting purpose
 r1=(sqrt(sum(r.^2)));
 t1=(sqrt(sum(t.^2)));
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if pflag
    
    % --- Accumulated distance matrix and optimal path
    figure('Name','DTW - Accumulated distance matrix and optimal path', 'NumberTitle','off');
    
    main1=subplot('position',[0.19 0.19 0.67 0.79]);
    image(D);
    
    cmap = contrast(D);
    colormap(cmap); % 'copper' 'bone', 'gray' imagesc(D);
    hold on;
    x=w(:,1); y=w(:,2);
    %avoid concidence of warping path with figure boundaries
    ind=find(x==1); x(ind)=1+0.2;
    ind=find(x==M); x(ind)=M-0.2;
    ind=find(y==1); y(ind)=1+0.2;
    ind=find(y==N); y(ind)=N-0.2;
    
    plot(y,x,'m.-', 'LineWidth',1);
    hold off;
    axis([1 N 1 M]);
    set(main1, 'XTickLabel',[], 'YTickLabel',[]);

    colorb1=subplot('position',[0.88 0.19 0.05 0.79]);
    nticks=8;
    ticks=floor(1:(size(cmap,1)-1)/(nticks-1):size(cmap,1));
    mx=max(max(D));
    mn=min(min(D));
    ticklabels=floor(mn:(mx-mn)/(nticks-1):mx);
    colorbar(colorb1);
    set(colorb1, 'FontSize',7, 'YTick',ticks, 'YTickLabel',ticklabels);
    set(get(colorb1,'YLabel'), 'String','Distance', 'Rotation',-90, 'FontSize',7, 'VerticalAlignment','bottom');
    %{
    left1=subplot('position',[0.07 0.19 0.10 0.79]);
    plot(r,M:-1:1,'b-*');
    set(left1, 'YTick',mod(M,10):10:M, 'YTickLabel',10*rem(M,10):-10:0)
    axis([min(r) 1.1*max(r) 1 M]);
    set(left1, 'FontSize',7);
    set(get(left1,'YLabel'), 'String','Samples', 'FontSize',7, 'Rotation',-90, 'VerticalAlignment','cap');
    set(get(left1,'XLabel'), 'String','Amp', 'FontSize',6, 'VerticalAlignment','cap');
    
    bottom1=subplot('position',[0.19 0.07 0.67 0.10]);
    plot(t,'r-o','Linewidth',1);
    axis([1 N min(t) 1.1*max(t)]);
    set(bottom1, 'FontSize',7, 'YAxisLocation','right');
    set(get(bottom1,'XLabel'), 'String','Samples', 'FontSize',7, 'VerticalAlignment','middle');
    set(get(bottom1,'YLabel'), 'String','Amp', 'Rotation',-90, 'FontSize',6, 'VerticalAlignment','bottom');
    %}
    % --- Warped signals
    figure('Name','DTW - warped signals', 'NumberTitle','off');
    
    subplot(1,2,1);
    set(gca, 'FontSize',7);
    hold on;
    plot(r1,'-bx');
    plot(t1,':ro');
    hold off;
    axis([1 max(M,N) min(min(r1),min(t1)) 1.1*max(max(r1),max(t1))]);
    grid;
    legend('signal 1','signal 2');
    title('Original signals');
    xlabel('Samples');
    ylabel('Amplitude');
    
    subplot(1,2,2);
    set(gca, 'FontSize',7);
    hold on;
    plot(rw1,'-bx');
    plot(tw1,':ro');
    hold off;
    axis([1 k min(min([rw1; tw1])) 1.1*max(max([rw1; tw1]))]);
    grid;
    legend('signal 1','signal 2');
    title('Warped signals');
    xlabel('Samples');
    ylabel('Amplitude');
    
end
