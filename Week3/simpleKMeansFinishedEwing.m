% Answers to Week 3 Assignment questions: 
% 2. a. Normalization in k-means clustering is important because the different dimensions are possibly  
% measured on different scales, affecting cluster determination. Normalization ensures that each 
% dimension is compared on an equal scale, obtaining the correct (intended) clusters.
% 2. b. Categorical data needs to be binarized, converted into indicator/dummy variables. The number
% of new variables will be equivalent to the number of categories in the original variable.
% 2. c. Clustering is unsupervised learning because the algorithm has no context or labeling for the 
% data. The algorithm simply takes the given data and its own structure to produce the outcome, with 
% no further input from the user. 

% 3. simpleKMeans calls the simpleAssignToCentroids function in the for loop below and returns 
% as output the clusterID vector which comprises the relevant clusters for each of the points (including 
% the 17th). 

% 4. simpleKMeans also calls the simpleDetermineCentroids function in the below for loop, returning
% as output the "centroids" vector which comprises the relevant centroids for each of the clusters (including
% cluster 2). 

% simpleKMeans is a 2D K-means implementation.  
% The function takes points and initial centroids and 
% returns centroids K-mean centroids
function centroids = simpleKMeansFinishedEwing(points, centroids)
% test:  centroids = simpleKMeans(simplePoints, [0, 0; -1, 0; 0, 1])
% test:  simpleKMeansTests
% Get ridiculous values for the initial cluster ids
clusterIDOld = -1;

% Parameters for normalization and de-normalization
% Determine the minimum and range of the points in both dimensions

minPts = min(points); 
minPts
maxPts = max(points);
maxPts
rangePts = maxPts - minPts; 
rangePts

% Normalize points
% for each dimension for each point subtract away its minimum and then divide by the range

numRows = size(points, 1); 
numCols = size(points, 2); 
rangePtsRep = repmat(rangePts, numRows, 1);
normPts = (points - minPts) ./ rangePtsRep; 
normPts

% Normalize Centroids
% For each dimension and centroid subtract away the minimum of the dimension that was
% determined by the points (not the centroids).  Then divide by the range of the dimension
% determined by the points (not the centroids).

numRows = size(centroids, 1); 
numCols = size(centroids, 2); 
rangeCentRep = repmat(rangePts, numRows, 1);
normCentroids = (centroids - minPts) ./ rangeCentRep;
normCentroids

% repeat the following processes using a loop.  Use a for loop to prevent infinite loops
for (iter1 = 1:20)
    % For each point find its closest cluster centre (centroid)
    clusterID = simpleAssignToCentroids(normPts, normCentroids);
    % If there was no change in cluster assignments, then stop;  Use "break" to break out of the loop
    if (sum(clusterID ~= clusterIDOld) < 1)   
        break;
    end % if
    % For each cluster of points determine its centroid;  The number of clusters is the number of centroids
    normCentroids = simpleDetermineCentroids(normPts, clusterID, size(normCentroids, 1));
    % remember clusterID before clusterID is re-assigned
    clusterIDOld = clusterID;
    % end the for loop
end % for

% Denormalization
% for each dimension for each centroid multiply by range of the dimension and then add the minimum
% of the dimension

deNormCentroids = (normCentroids .* rangeCentRep) + minPts; 
deNormCentroids

% End the function
return
