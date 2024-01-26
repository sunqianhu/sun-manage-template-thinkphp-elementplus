<?php

namespace app\manage\controller\statistic\order;

use app\manage\controller\Base;
use app\manage\validate\Order as OrderValidate;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use think\exception\ValidateException;

class Trend extends Base
{
    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $get = $this->request->get(['add_time' => []]);

        // 验证
        try {
            validate(OrderValidate::class)->scene('statistic_trend')->check($get);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (count($get['add_time']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $startTime = $get['add_time'][0];
        $endTime = $get['add_time'][1];
        if ($endTime - $startTime > 60 * 60 * 24 * 90) {
            return $this->error("统计日期不能大于90天");
        }

//        $query = InfoModel::field('add_time')
//            ->whereBetween('add_time', $get['add_time']);
//        $infoModels = $query->select();

        $infos = [];
        for ($time = $startTime; $time < $endTime; $time += 24 * 60 * 60) {
            $info = [
                'name' => date('j日', $time),
                'full_name' => date('Y年m月j日', $time),
                'number' => rand(0, 50)
            ];

//            foreach ($infoModels as $infoModel) {
//                if ($infoModel->add_time < $time || $infoModel->add_time >= $time + 24 * 60 * 60) {
//                    continue;
//                }
//                $info['number']++;
//            }
            $infos[] = $info;
        }

        return $this->success('获取成功', $infos);
    }

    /**
     * 导出excel
     * @return void
     */
    public function exportExcel()
    {
        $get = $this->request->get(['add_time' => []]);

        // 验证
        try {
            validate(OrderValidate::class)->scene('statistic_trend_export_excel')->check($get);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (count($get['add_time']) != 2) {
            return $this->error('添加时间参数错误');
        }

        $startTime = $get['add_time'][0];
        $endTime = $get['add_time'][1];
        if ($endTime - $startTime > 60 * 60 * 24 * 90) {
            return $this->error("统计日期不能大于90天");
        }

        $infos = [];
        for ($time = $startTime; $time < $endTime; $time += 24 * 60 * 60) {
            $info = [
                'name' => date('j日', $time),
                'full_name' => date('Y年m月j日', $time),
                'number' => rand(0, 50)
            ];

//            foreach ($infoModels as $infoModel) {
//                if ($infoModel->add_time < $time || $infoModel->add_time >= $time + 24 * 60 * 60) {
//                    continue;
//                }
//                $info['number']++;
//            }
            $infos[] = $info;
        }

        //excel
        $spreadsheet = new Spreadsheet();
        $activeSheet = $spreadsheet->getActiveSheet();

        $activeSheet->setCellValue('A1', '日期');
        $activeSheet->setCellValue('B1', '订单数量');
        $row = 1;
        foreach ($infos as $info) {
            $row++;
            $activeSheet->setCellValue('A' . $row, $info['full_name']);
            $activeSheet->setCellValue('B' . $row, $info['number']);
        }
        $activeSheet->getColumnDimension('A')->setAutoSize(true);
        $activeSheet->getColumnDimension('B')->setAutoSize(true);

        //输出
        header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        header("Content-Disposition: attachment;filename=example.xlsx");
        header("Cache-Control: max-age=0");

        $writer = new Xlsx($spreadsheet);
        $writer->save('php://output');
    }
}