
p = [6.868286	44.282037
    6.278286	44.282037
    6.451097	44.615788
    6.868286	44.754037
    7.285475	44.615788
    7.458286	44.282037
    7.285475	43.948286
    6.868286	43.810037
    6.451097	43.948286
    2.944031	30.444715
    2.09521	    31.264412
    2.807516	31.504484
    3.599788	31.123772
    4.007918	30.345269
    3.792852	29.625019
    3.080546	29.384947
    2.288273	29.765659
    1.880143	30.544162
    16.009216	24.874765
    15.488277	25.151753
    15.797547	25.365308
    16.230807	25.291516
    16.534259	24.973591
    16.530155	24.597777
    16.220886	24.384222
    15.787626	24.458014
    15.484174	24.775939
    16.484222	67.592
    16.179154	67.689124
    16.645944	67.868308
    16.789291	67.494876
    16.322501	67.315692
    23.245087	41.549222
    23.025354	41.782069
    23.520488	41.712482
    23.464819	41.316375
    22.969685	41.385961];

%n = 1000;
%p = zeros(n,2);
%rng(0.5,'twister');
%p(:,1) = rand(n,1);
%p(:,2) = rand(n,1);
s = size(p);
s = s(1,1);
VD = Voronoi(s,3);
for i = 1:37
    e = Evento(p(i,1),p(i,2));
        VD.heap.insertEvent(e);
end
xmin  = 0;
ymin = 0;
xmax = 30;
ymax = 80;
while VD.heap.currentSize > 0
    currentEvent = VD.heap.removeEvent();
    %Verifica si el evento es válido
    if ~currentEvent.type      
        VD.handleSiteEvent(currentEvent); 
        %counter1 = counter1 + 1;        
    elseif currentEvent.valido
        VD.handleCircleEvent(currentEvent, xmin, ymin, xmax, ymax);  
        %counter2 = counter2 + 1;
    end
    
end
voronoi(p(:,1), p(:,2));
hold on
VD.dcel.drawVertex();
VD.dcel.processFaces(xmin, ymin, xmax, ymax);
