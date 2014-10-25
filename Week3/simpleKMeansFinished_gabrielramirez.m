% simpleKMeans is a 2D K-means implementation.  
% The function takes points and initial centroids and 
% returns centroids K-mean centroids

function centroids = simpleKMeansFinished_gabrielramirez(points, centroids)

% test:  centroids = simpleKMeansFinished(simplePoints, [0, 0; -1, 0; 0, 1])
% test:  simpleKMeansTests
% Get ridiculous values for the initial cluster ids
clusterIDOld = -1;
% Parameters for normalization and de-normalization
% Determine the minimum and range of the points in both dimensions
% Missing code:

%get the min of points
minOfPoints = min(points);
%get the max of points
maxOfPoints = max(points);
%get the range of points
rangeOfPoints = maxOfPoints - minOfPoints;

% Normalize points
% for each dimension for each point subtract away its minimum and then divide by the range
% Missing code:

%get the number of rows
numberOfRows = size(points, 1);
%loop through each row to normalize and place the results in new matrix
%I know this isn't the 'preferred' method, but it's the most explicit function
%which I could apply to any computer lang. Also it might be more efficient
%because you don't have to create second matrix of the same dims
for row = 1:numberOfRows
    points(row, : ) = (points(row, : ) - minOfPoints) ./ rangeOfPoints;
end

%just for keeping notes below is how you would use repmat
%points = (points - repmat(minOfPoints,numberOfRows,1)) ./ repmat(rangeOfPoints,numberOfRows,1);

% Normalize Centroids
% For each dimension and centroid subtract away the minimum of the dimension that was
% determined by the points (not the centroids).  Then divide by the range of the dimension
% determined by the points (not the centroids).
% Missing code:

%get the number of centroid rows
numberofCentroidRows = size(centroids, 1)
%loop through each row to normalize the centroids
for row = 1:numberofCentroidRows
    centroids(row, : ) = (centroids(row, : ) - minOfPoints) ./ rangeOfPoints;
end

%just for keeping notes here is how you you would use repmat
%centroids = (centroids - repmat(minOfPoints,numberofCentroidRows,1)) ./ repmat(rangeOfPoints,numberofCentroidRows,1);


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
% for each dimension for each centroid multiply by range of the dimension 
% and then add the minimum of the dimension
% Missing code:

for row = 1:numberofCentroidRows
    centroids(row, : ) = (centroids(row, : ) .* rangeOfPoints) +  minOfPoints ;
end

%just for keeping notes here is how you you would use repmat
%centroids = (centroids .* repmat(rangeOfPoints,numberofCentroidRows,1)) + repmat(minOfPoints,numberofCentroidRows,1);

% End the function
return
