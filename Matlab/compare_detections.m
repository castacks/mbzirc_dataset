function isSame = compare_detections(info1, info2, ind1, ind2)

isSame = false;

W = info1.TargetWidth(ind1);
H = info1.TargetHeight(ind1);

dist_thresh = min(W, H) * 0.1;
w_thresh = W * 0.1;
h_thresh = H * 0.1;

distX = (info1.TargetCenterX(ind1) - info2.TargetCenterX(ind2));
distY = (info1.TargetCenterY(ind1) - info2.TargetCenterY(ind2));

if distX * distX + distY * distY > dist_thresh * dist_thresh
%    fprintf("Rejected for center: %0.2f > %0.2f\n", distX * distX + distY * distY, dist_thresh * dist_thresh);
    return;
end

if abs(info2.TargetWidth(ind2) - W) > w_thresh
%    fprintf("Rejected for width: %0.2f > %0.2f\n", abs(info2.TargetWidth(ind2) - W), w_thresh);
    return
end

if abs(info2.TargetHeight(ind2) - H) > h_thresh
%    fprintf("Rejected for height: %0.2f > %0.2f\n", abs(info2.TargetHeight(ind2) - H), h_thresh);
    return
end

isSame = true;