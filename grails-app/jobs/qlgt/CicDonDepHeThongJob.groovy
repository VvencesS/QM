package qlgt

import com.melanin.commons.Conf
import com.melanin.commons.MelaninLogAction

class CicDonDepHeThongJob {
    static triggers = {
        cron name: 'cronDonDepHeThongJob', startDelay: 10000, cronExpression: '0 0 23 1/1 * ? *'
    }

    def execute() {
        // execute job
        def conf = Conf.findByType('soNgayLuuLog')
        def soNgay = Integer.valueOf(conf.value)
        Date dt = new Date()
        Calendar c = Calendar.getInstance();
        c.setTime(dt);
        c.add(Calendar.DATE, -soNgay);
        dt = c.getTime();
        MelaninLogAction.executeUpdate 'DELETE FROM MelaninLogAction WHERE actiontime < :date', [date: dt]
    }
}
