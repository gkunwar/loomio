namespace :srt do

LOCALES = [ :en, :cs, :ca, :pt_BR, :ja, :el, :fr ]

VIDEO_TEMPLATE = {
  t06: '00:00:04,420 --> 00:00:07,509',
  t07: '00:00:07,509 --> 00:00:11,309',
  t08: '00:00:12,910 --> 00:00:16,920',
  t09: '00:00:16,920 --> 00:00:25,920',
  t10: '00:00:25,920 --> 00:00:29,150',
  t11: '00:00:29,150 --> 00:00:35,200',
  t12: '00:00:35,200 --> 00:00:40,370',
  t13: '00:00:40,370 --> 00:00:44,370',
  t14: '00:00:47,370 --> 00:00:48,980',
  t15: '00:00:48,980 --> 00:00:58,190',
  t16: '00:00:58,190 --> 00:01:02,290',
  t17: '00:01:02,290 --> 00:01:06,510',
  t18: '00:01:06,510 --> 00:01:08,510', #Now it's time..real thing
  t19: '00:01:08,510 --> 00:01:13,180', #Loomio 1.0
  t20: '00:01:13,180 --> 00:01:15,659', #At its core..
  t21: '00:01:15,659 --> 00:01:18,600',
  t22: '00:01:18,600 --> 00:01:20,600', #buid agreement..
  t23: '00:01:20,600 --> 00:01:25,340',
  t24: '00:01:25,340 --> 00:01:32,950',
  t26: '00:01:32,950 --> 00:01:39,670',
  t28: '00:01:39,670 --> 00:01:44,200',
  t31: '00:01:44,200 --> 00:01:49,540',
  t32: '00:01:49,540 --> 00:01:52,840',
  t33: '00:01:52,840 --> 00:01:56,740',
  t34: '00:01:56,740 --> 00:02:03,159',
  t35: '00:02:03,159 --> 00:02:08,610', #We've done all the..
  t36a: '00:02:08,610 --> 00:02:19,819',
  t36b: '00:02:19,819 --> 00:02:26,610',
  t37: '00:02:26,610 --> 00:02:29,470',
  t38: '00:02:29,470 --> 00:02:35,280',
  t39: '00:02:35,280 --> 00:02:42,290',
  t40: '00:02:42,290 --> 00:02:44,290',
  t41: '00:02:44,290 --> 00:02:48,590',
  t42: '00:02:48,590 --> 00:02:53,350'
}

SRT_FILE_NAME = "loomio_cf"

  task :build => :environment do
    puts "generating srt for #{LOCALES}"
    ordered_times = VIDEO_TEMPLATE.values.sort

    LOCALES.each do |locale|
      rows = []
      ordered_times.each do |time|
        key = "video.#{VIDEO_TEMPLATE.key(time)}"

        row =[]
        row << time
        row << I18n.t(key ,locale: locale)

        rows << row
      end

      File.open("tmp/#{SRT_FILE_NAME}.#{locale}.srt", 'w') do |file|
        rows.each_with_index do |row,i|
          file.puts i+1
          file.puts row[0]
          file.puts row[1]
          file.puts ""
        end
      end

    end

    puts `cat tmp/#{SRT_FILE_NAME}.en.srt`
  end

end