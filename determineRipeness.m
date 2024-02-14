function ripe = determineRipeness(dominantFrequency, ripeThreshold, unripeThreshold)
    % 基于主导频率和阈值确定成熟度的函数
    if dominantFrequency > ripeThreshold
        ripe = true; % 西瓜成熟
    elseif dominantFrequency < unripeThreshold
        ripe = false; % 西瓜未成熟
    else
        ripe = []; % 无法确定成熟度
    end
end