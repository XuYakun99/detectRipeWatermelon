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

function [frequencies, powerSpectrum, dominantFrequency] = performFourierTransform(sound, Fs)
    % 对声音数据执行傅里叶变换的函数
    L = length(sound);
    Y = fft(sound);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    frequencies = Fs*(0:(L/2))/L;
    powerSpectrum = P1;
    
    % 寻找主导频率
    [~, index] = max(powerSpectrum);
    dominantFrequency = frequencies(index);
    
    % 绘制频谱图并标注主频
    figure;
    plot(frequencies, powerSpectrum);
    hold on;
    plot(dominantFrequency, powerSpectrum(index), 'ro', 'MarkerSize', 10); % 标注主频
    title('Frequency Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Power');
    legend('Power Spectrum', 'Dominant Frequency');
    
end

function sound = importSound(filename)
    % 从文件中导入声音数据的函数
    [sound, ~] = audioread(filename); % 导入声音并丢弃采样频率
end

function sound = recordSound(recorder, duration)
    % 实时录制声音数据的函数
    disp('请说话：'); % 提示用户开始说话
    recordblocking(recorder, duration); % 录制指定时长的声音
    disp('录音结束！');
    sound = getaudiodata(recorder); % 从录音器中获取声音数据
end



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
