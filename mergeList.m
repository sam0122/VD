function mergeList( list, center, l, m, r )
%Función auxiliar de la rutina MergeSort
    n1 = m - l + 1;
    n2 = r - m;
    %Array temporal
    L = zeros(n1, 2);
    R = zeros(n2,2);
    %Copiar info a arrays temp
    for i = 1:n1
            L(i,:) = list(i,:);
    end
    
    for j = 1:n2
            R(j,:) = list(m + j,:);
    end
    %Combinar arrays
    i = 1;
    j = 1;
    k = l;
    
    while i <= n1 && j <= n2
        if ~compareCW(L(i,:), R(j,:), center)
            list(k,:) = L(i,:);
            i = i + 1;
        else
            list(k,:) = R(j,:);
            j = j + 1;
        end
        k = k + 1;
    end
    %Copiar elementos remanentes de L
    while i <= n1
        list(k,:) = L(i,:);
        i = i + 1;
        k = k + 1;
    end
    %Copiar elementos remanentes de R
    while j <= n2
        list(k ,:) = R(j,:);
        j = j + 1;
        k = k + 1;
    end


end

