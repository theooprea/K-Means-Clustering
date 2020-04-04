function [centroids points2] = clustering_pc(points, NC)
  [n m] = size(points);
  centroids = zeros(NC, m);
  puncte_care_tin_de_cluster = zeros(NC, 1);
  for i = 1 : NC
    for j = i : NC : n
      for k = 1 : m
        centroids(i,k) = centroids(i,k) + points(j,k);
      end
      puncte_care_tin_de_cluster(i, 1) = puncte_care_tin_de_cluster(i, 1) + 1;
    end
  end
   for i = 1 : NC
    for k = 1 : m
      centroids(i,k) = centroids(i,k) / puncte_care_tin_de_cluster(i, 1);
    end
  end
  new_column = zeros(n,1);
  points2 = [points new_column];
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
      end
    end
  end
  centroids_new = zeros(NC, m);
  puncte_care_tin_de_cluster = zeros(NC, 1);
  for i = 1 : n
    puncte_care_tin_de_cluster(points2(i, m + 1), 1) = puncte_care_tin_de_cluster(points2(i, m + 1), 1) + 1;
    for j = 1 : m
      centroids_new(points2(i, m + 1), j) = centroids_new(points2(i, m + 1), j) + points(i,j);
    end
  end
  for i = 1:NC
    for j = 1:m
      centroids_new(i, j) = centroids_new(i, j) / puncte_care_tin_de_cluster(i, 1);
    end
  end
  while(!isequal(centroids, centroids_new))
    centroids = centroids_new;
    new_column = zeros(n,1);
    points2 = [points new_column];
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
        end
      end
    end
    centroids_new = zeros(NC, m);
    puncte_care_tin_de_cluster = zeros(NC, 1);
    for i = 1 : n
      puncte_care_tin_de_cluster(points2(i, m + 1), 1) = puncte_care_tin_de_cluster(points2(i, m + 1), 1) + 1;
      for j = 1 : m
        centroids_new(points2(i, m + 1), j) = centroids_new(points2(i, m + 1), j) + points(i,j);
      end
    end
    for i = 1:NC
      for j = 1:m
        centroids_new(i, j) = centroids_new(i, j) / puncte_care_tin_de_cluster(i, 1);
      end
    end
  end
endfunction
