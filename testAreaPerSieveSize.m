% Part two.
% Calculate number of particles per sieve, given agArea and gradation.
smpArea = 0.14*0.11;
agCovers = 0.70;
grad = 6;
nAgs = 500;
% sieve sizes [m]
s=[0.00118, 0.00236, 0.00475, 0.0095, 0.0125, 0.019, 0.025];

%%% ratio of >1.18mm WEIGHT (i.e. VOLUME) retained per sieve, relative to >1.18mm

switch grad
    case 1 % 9.5mm
        rws=[0.55725; 0.34351; 0.09160; 0.00763; 0; 0];
    case 2 % 12.5mm (a)
        rws=[0.16250; 0.33750; 0.37500; 0.08750; 0.03750; 0];
    case 3 % 12.5mm (b)
        rws=[0.28788; 0.24242; 0.24242; 0.16667; 0.06061; 0];
    case 4 % 12.5mm (c)
        rws=[0.23944; 0.31925; 0.23005; 0.19092; 0.02034; 0]; 
    case 5 % 19.0 mm
        rws=[0.12308; 0.29091; 0.22238; 0.17902; 0.17902; 0.00559];
    case 6 % open (measured)
        rws=[
            0.04250; % 1.18 mm, #16
            0.28117; % 2.36 mm, # 8
            0.56718; % 4.75 mm, # 4
            0.06176; % 9.50 mm, 3/8''
            0.04739; % 12.5 mm, 1/2''
            0];      % 19.0 mm, 3/4''
end

%%% calculate area and volume of intermediate-sieve spheres

nSieves=size(s,2);
aOequivs=zeros(1,nSieves-1);
vOequivs=zeros(1,nSieves-1);
for i=1:nSieves-1
    s1=s(1,i);
    s2=s(1,i+1);
    rMean=(s1+s2)/4;
    aOequivs(1,i)=pi*rMean^2;
    vOequivs(1,i)=(4/3)*pi*rMean^3;
end

%%% normalized ratio of 'area' (equivalent circles) retained per sieve

aRatio=zeros(1,nSieves-1);
for i=1:nSieves-1
    aOequiv=aOequivs(1,i);
    vOequiv=vOequivs(1,i);
    aRatio(1,i)=(aOequiv/vOequiv)*rws(i,1);
end
aRatio=aRatio/sum(aRatio);

%%% calculate area per sieve and estimate number of particles per sieve
aSieve=zeros(1,nSieves-1);
nParts=zeros(1,nSieves-1);
agAreaTarget=agCovers*smpArea;
for i=1:nSieves-1
    aSieve(1,i)=agAreaTarget*aRatio(1,i);
    nParts(1,i)=aSieve(1,i)/aOequivs(1,i);
end

% this number emerges as the 'natural' number of aggregates needed for these conditions (gradation and ag area).
nAgsArises = sum(nParts);
%%% adjust number of particles to target nAgs

% ratio of particles per sieve
nParts=nParts/nAgsArises;

for i=1:nSieves-1
    nParts(1,i)=nParts(1,i)*nAgs;
end

%%% round number of particles, adjust to nAg and accumulate
for i=1:nSieves-1
    nParts(1,i)=ceil(nParts(1,i));
end
nAgsUp=sum(nParts);

if nAgsUp~=nAgs
    [void,I]=max(nParts);
    nParts(1,I(1,1))=nParts(1,I(1,1))-(nAgsUp-nAgs);
end

nPartsAcum=zeros(1,nSieves-1);
for i=1:nSieves-1
    nPartsAcum(1,i)=sum(nParts(1:i));
end
