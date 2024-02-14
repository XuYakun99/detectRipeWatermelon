function sound = recordSound(recorder, duration)
    % 实时录制声音数据的函数
    disp('请说话：'); % 提示用户开始说话
    recordblocking(recorder, duration); % 录制指定时长的声音
    disp('录音结束！');
    sound = getaudiodata(recorder); % 从录音器中获取声音数据
end



