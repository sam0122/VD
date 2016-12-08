
seedSkip = randi(20000,1,1);
%seedLeap = primes(seedSkip);
%s = size(seedLeap);
%s = s(1,2);
%s = randi(s,1,1);
h = haltonset(2,'Skip', seedSkip);
h = scramble(h,'RR2');
center = net(h,1000);

%h = rand(50000,2);
%center=  zeros(10000,2);
%for i = 1:10000
%    center(i,:) = h(i,:);
%end
plot(center(:,1),center(:,2),'*');