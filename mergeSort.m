function list = mergeSort(list, center)
    len = size(list);
    len = len(1,1);
    if len > 1
        mid = floor(len*0.5);
        lefthalf = list(1:mid,:);
        righthalf = list(mid:len,:);

        list = mergeSort(lefthalf, center);
        list = mergeSort(righthalf, center);

        i=0;
        j=0;
        k=0;
        sizeLeftHalf = size(lefthalf);
        sizeRightHalf = size(rightHalf);
        while i < sizeLeftHalf && j < sizeRightHalf
            if compareCW(righthalf(j,:),lefthalf(i,:),center)%Verificación de cw
                list(k,:) = lefthalf(i,:);
                i=i+1;
            else
                list(k,:) = righthalf(j,:);
                j=j+1;
            end
            k=k+1;
        end

        while i < sizeLeftHalf
            list(k,:) = lefthalf(i,:);
            i=i+1;
            k=k+1;
        end

        while j < sizeRightHalf
            list(k,:) = righthalf(j,:);
            j=j+1;
            k=k+1;
        end
    end
end
