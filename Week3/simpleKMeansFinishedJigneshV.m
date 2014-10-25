%Week 3 Assignment
%Jignesh Vyas
% 1. In class assignment
% Submitted on 10/21

% 2. A Why is normalization important in K-means clustering?
% Ans. Data normalization is one of the key preprocessing steps in Data mining. K-mean clustering uses Euclidean distance to measure
% distance between object and the centroids, which is sensitive to the magnitude of data. In real scenario data might be skewed due to
% outliers or in some cases 2 attribute would have different scale like e.g. Salary and Age. Normalization helps in keeping data within range and 
% makes it comparable.
%
% 2. B How do you encode categorical data in a K-means clustering?
% Categorical variable should be binarized for K-mean clustering

%
% 2. C Why is clustering un-supervised learning as opposed to supervised learning?
% Ans. Clustering is process to find pattern in large data set as opposed to labelling data and doesnt require uses input, hence it is un-supervised. 

% 3 Given the following: simpleAssignToCentroids assigns the 17th point to a centroid by measuring the distance of the 17th point to each centroid. 
% The centroid with the smallest distance to the 17th point is the point’s centroid. 
% How does simpleKMeans know which centroid was chosen for the 17th point? (Answer in one sentence or less) 
% Ans. simpleAssignToCentroid returns the minimum distance centroid,as index which is the cluster number.
 
 
% 4 Given the following: simpleDetermineCentroids determines centroid for cluster 2 by finding the mean of all points that belong to cluster 2. 
% How does simpleKMeans know which returned centroid is the one for cluster 2? (Answer in one sentence or less) 
% Ans. simpleDetermineCentroids returns a matrix called centroids (2X2 matrix), which has centroid index and mean of that cluster.



% simpleKMeans is a 2D K-means implementation.  
% The function takes points and initial centroids and 
% returns centroids K-mean centroids

% NOTE : Changed the function name to simpleKmeansFinished to match the file name
function centroids = simpleKMeansFinished(points, centroids)
% test:  centroids = simpleKMeans(simplePoints, [0, 0; -1, 0; 0, 1])
% test:  simpleKMeansTests
% Get ridiculous values for the initial cluster ids
clusterIDOld = -1;

% Parameters for normalization and de-normalization
% Determine the minimum and range of the points in both dimensions
% Missing code:

% find the min of the input points
lower=min(points)
% find the max of the input points
upper=max(points)
% calculate range
range=upper-lower



% Normalize points
% for each dimension for each point subtract away its minimum and then divide by the range
% Missing code:
% calculate row length
rowsize=size(points,1);
% subtract min from each of the points in the matrix
% NOTE since min are negatives (-22,-2.27), subtraction causes points to increase (added) by min value.
points=points-repmat(lower,rowsize,1);
% dividing by range
points(:,1)=points(:,1)./range(1);
points(:,2)=points(:,2)./range(2);
%check
points

% Normalize Centroids
% For each dimension and centroid subtract away the minimum of the dimension that was
% determined by the points (not the centroids).  Then divide by the range of the dimension
% determined by the points (not the centroids).
% Missing code:

% for dimension subtraction of minimum for each points and dividing by range is done in above steps
sizeCentroids = size(centroids); 
centroids = centroids - repmat(lower, sizeCentroids(1), 1) ;
centroids(:, 1) = centroids(:, 1)./ range(1) ;
centroids(:, 2) = centroids(:, 2)./ range(2) ;
%check
centroids

% repeat the following processes using a loop.  Use a for loop to prevent infinite loops
for (iter1 = 1:20)
    % For each point find its closest cluster centre (centroid)
    clusterID = simpleAssignToCentroids(points, centroids);
    % If there was no change in cluster assignments, then stop;  Use "break" to break out of the loop
    if (sum(clusterID ~= clusterIDOld) < 1)   
        break;
    end % if
    % For each cluster of points determine its centroid;  The number of clusters is the number of centroids
    centroids = simpleDetermineCentroids(points, clusterID, size(centroids, 1));
    % remember clusterID before clusterID is re-assigned
    clusterIDOld = clusterID;
    % end the for loop
end % for

% Denormalization
% for each dimension for each centroid multiply by range of the dimension and then add the minimum
% of the dimension
% Missing code:

%dimension
% multiply by range
points(:,1)=points(:,1).*range(1);
points(:,2)=points(:,2).*range(2);

%add minimum
points=points+repmat(lower,rowsize,1);
% check
points

%Centroids
% multiple by range
sizeCentroids = size(centroids); 
centroids(:, 1) = centroids(:, 1).*range(1); 
centroids(:, 2) = centroids(:, 2).*range(2);
%add minimum
centroids = centroids + repmat(lower, sizeCentroids(1), 1) ;

% End the function
return
