function ripe = detectRipeWatermelon(ripeThreshold, unripeThreshold, sound)
    % 根据声音分析来检测西瓜是否成熟的函数
    
    try
        if nargin < 3
            % 默认使用实时录制声音
            duration = 5; % 默认录制5秒钟的声音
            recorder = audiorecorder; % 创建音频录制器对象
            sound = recordSound(recorder, duration); % 实时录制声音
            Fs = recorder.SampleRate; % 获取采样频率
        end
        
        % 执行傅里叶变换
        [frequencies, powerSpectrum, dominantFrequency] = performFourierTransform(sound, Fs);
        
        % 基于阈值确定成熟度
        ripe = determineRipeness(dominantFrequency, ripeThreshold, unripeThreshold);
        
    catch exception
        % 处理可能出现的异常情况
        disp(['错误: ', exception.message]);
        ripe = []; % 返回空值以指示失败
    end
end



