% DATASCI 250: Introduction to Data Science (4690)
% Autumn 14
% Instructor: Ernst Henle
%
% Homework 3
%
% Submitted by:
% Werner Colangelo
% wernercolangelo@gmail.com


% simpleKMeans is a 2D K-means implementation.  
% The function takes points and initial centroids and 
% returns centroids K-mean centroids
function centroids = simpleKMeans(points, centroids)
% test:  centroids = simpleKMeans(simplePoints, [0, 0; -1, 0; 0, 1])
% test:  simpleKMeansTests
% Get ridiculous values for the initial cluster ids
clusterIDOld = -1;

% Question 2
% a.Why is normalization important in K-means clustering?
% Normalizations are important for clustering so that the data (quoting the class notes) are on "equal terms".
% If you have 2D points where the order of magnitude of the first dimension was very much larger than the second,
% then this would force the points to cluster in the "direction" of the first dimension. By normalizing the data you are
% able to avoid this dominaiton of one dimension over another.

% b.How do you encode categorical data in a K-means clustering?
% Categorical data needs to be binarized in order to be used in K-means clustering 

% c.Why is clustering un-supervised learning as opposed to supervised learning?
% K-means is unsupervised because we do not tell the algorithm what outcome was observed or what outcome is desired.

% Question 3
% Given the following: simpleAssignToCentroids assigns the 17th point to a centroid by measuring the distance of the 17th point to each centroid.
% The centroid with the smallest distance to the 17th point is the point’s centroid.
% How does simpleKMeans know which centroid was chosen for the 17th point? (Answer in one sentence or less)
% simpleAssignToCentroids returns a vector called clusterID where clusterID(index_i) is the cluster for point(index_i, :)

% Question 4
% Given the following: simpleDetermineCentroids determines centroid for cluster 2 by finding the mean of all points that belong to cluster 2.
% How does simpleKMeans know which returned centroid is the one for cluster 2? (Answer in one sentence or less)
% simpleDetermineCentroids returns a matrix called centroids where centroids(index_i, :) is the centroid for cluster index_i

% Parameters for normalization and de-normalization
% Determine the minimum and range of the points in both dimensions
% Missing code:
minPoints = min(points)
maxPoints = max(points)
rangePoints = maxPoints - minPoints

% Normalize points
% for each dimension for each point subtract away its minimum and then divide by the range
% Missing code:
sizePoints = size(points)
points = points - repmat(minPoints,  sizePoints(1), 1)
points(:, 1) = points(:, 1) ./ rangePoints(1)
points(:, 2) = points(:, 2) ./ rangePoints(2)

% Normalize Centroids
% For each dimension and centroid subtract away the minimum of the dimension that was
% determined by the points (not the centroids).  Then divide by the range of the dimension
% determined by the points (not the centroids).
% Missing code:
sizeCentroids = size(centroids)
centroids = centroids - repmat(minPoints, sizeCentroids(1), 1)
centroids(:, 1) = centroids(:, 1) ./ rangePoints(1)
centroids(:, 2) = centroids(:, 2) ./ rangePoints(2)

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
centroids(:, 1) = centroids(:, 1) .* rangePoints(1)
centroids(:, 2) = centroids(:, 2) .* rangePoints(2)
centroids = centroids + repmat(minPoints, sizeCentroids(1), 1)

% End the function
return
