function [cost] = compute_cost_pc(points, centroids)
  [n m] = size(points);
  [NC m] = size(centroids);
  new_column = zeros(n,1);
  points2 = [points new_column];
  cost = 0;
  for i = 1 : n
    minim = norm(points(i,:) - centroids(1,:));
    for j = 2 : NC
      if(norm(points(i,:) - centroids(j,:)) < minim)
        minim =  norm(points(i,:) - centroids(j,:));
      end
    end
    for j = 1 : NC
      if(minim == norm(points(i,:) - centroids(j,:)))
        points2(i, m + 1) = j;
        cost = cost + minim;
      end
    end
  end
  %for i = 1 : n
    %cost = cost + norm(points(i,:) - centroids(points2(i, m + 1)));
  %end
  %disp(points2);
endfunction

