%{
function mergeSort(list, center, l, r)
    if l < r
        m = fix(l +  (r-1))*0.5;
        mergeSort(list, center, l, m);
        mergeSort(list, center, m + 1, r);
        mergeList(list, center, l , m, r);
    end
end
%}
%{
function list = mergeSort(list, center)
 
    if length(list) <= 1
        return
    else
        middle = ceil(length(list)*0.5);
        left = list(1:middle,:);
        right = list(middle+1:end,:);
 
        left = mergeSort(left,center);
        right = mergeSort(right,center);
 
        if ~compareCW(left(end,:),right(1,:),center)
            list = [left;right];
            return
        end
 
        %merge(left,right)
        counter = 1;
        while ~ismepty(left) && ~isempty(right)
            if ~compareCW(left(1,:),right(1,:), center)
                list(counter,:) = left(1,:);
                left(1,:) = [];
            else
                list(counter,:) = right(1,:);
                right(1,:) = [];
            end           
            counter = counter + 1;   
        end
 
        if ~isempty(left)
            list(counter:end,:) = left;
        elseif ~isempty(right)
            list(counter:end,:) = right;
        end
        %end merge        
    end %if
end %mergeSort
%}
function list = mergeSort(list,center)
    s = size(list);
    s = s(1,1);
    if  s <= 1
        return
    else
        middle = ceil(s*0.5);
        left = list(1:middle,:);
        right = list(middle+1:end,:);
 
        left = mergeSort(left, center);
        right = mergeSort(right, center);
        A = left(end,:);
        B = right(1,:);
        if ~compareCW(A,B,center)
            list = [left;right];
            return
        end
 
        %merge(left,right)
        counter = 1;
        while ~isempty(left) && ~isempty(right)
            A = left(1,:);
            B = right(1,:);
            if ~compareCW(A,B,center)
                list(counter,:) = left(1,:);
                left(1,:) = [];
            else
                list(counter,:) = right(1,:);
                right(1,:) = [];
            end           
            counter = counter + 1;   
        end
 
        if ~isempty(left)
            list(counter:end,:) = left;
        elseif ~isempty(right)
            list(counter:end,:) = right;
        end
        %end merge        
    end %if
end %mergeSort