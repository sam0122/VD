%Función que encuentra las tripletas consecutivas que aparecen al insertar
%un arco nuevo
function trip = triples(arcs)
            
            trip =  cell(1,2);
            
            pj2= arcs{1,1};
            pi= arcs{1,2};
            pj = arcs{1,3}; 
            
            pPrev = pj2.prev;
            pNext = pj.next;
            
            if isempty(pPrev)
                 trip{1,1} = [];
            else
                trip{1,1} = [pPrev,pj2,pi];
            end
            
            if isempty(pNext)
                 trip{1,2} = [];
            else
                trip{1,2} = [pi,pj,pNext];
            end
            
           
            
            
            %Primer elemento de la celda guarda la tripleta en la que pi es
            %el nodo izquierdo.Segundo elemento guarda la tripleta enla que
            %pi es el nodo derecho.
            
            %{
            n1 = pi.parent;
            n1p= n1.parent;
            found = false;
            
            if eq(n1,n1p.lLink)
                n2 = n1p.rLink;
                if n2.isArc == 0
                    while found == false
                        if n2.isArc == 0
                             n2 = n2.lLink;
                        else
                             pk = n2;
                             found = true;
                             trip{1,1} = [pi,pj,pk];
                        
                        end
                    
                    end
                else
                    trip{1,1} = [];
                end
                
            else
                n2 = n1p.lLink;
                if n2.isArc == 0
                    while found == false
                        if n2.isArc == 0
                             n2 = n2.rLink;
                        else
                            pk = n2;
                            found = true;
                            trip{1,2} = [pk,pj,pi];
                        end
                    
                    end
                else
                    trip{1,2} = [];
                end
                
            end
            
            n3 = pi.parent;
            n4 = n3. parent;
            n5 = n4.parent;
            
            if isempty(n5)== 0
                if eq(n4,n5.rLink)
                    n6 = n5.lLink;
                    while found == false
                        if n6.isArc == 0
                             n6 = n6.rLink;
                        else
                             pm = n6;
                             found = true;
                             trip{1,2} = [pm,pj2,pi];
                        
                         end
                    
                    end
                else
                    n6 = n5.rLink;
                    while found == false
                         if n6.isArc == 0
                             n6 = n6.lLink;
                         else
                              pm = n6;
                              found = true;
                              trip{1,1} = [pi,pj2,pm];
                        
                         end
                    
                    end
                    
                end
                
                
                
            end
            %}
        end