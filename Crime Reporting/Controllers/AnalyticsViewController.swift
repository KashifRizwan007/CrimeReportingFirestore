//
//  AnalyticsViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 8/5/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import Charts

class AnalyticsViewController: UIViewController {

    @IBOutlet weak var chart: PieChartView!
    @IBOutlet weak var chart1: BarChartView!
    
    var karachiData = PieChartDataEntry(value: 0)
    var lahoreData = PieChartDataEntry(value: 0)
    var islamabadData = PieChartDataEntry(value: 0)
    var rawalpindiData = PieChartDataEntry(value: 0)
    var cities = ["Karachi","Lahore","Islamabad","Rawalpindi"]
    var crime = [String]()
    var complaints = [String]()
    var missingPersons = [String]()
    
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0]
    let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0]
    
    var totalDataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        setChart()
        configuraData()
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setChart() {
        let legend = chart1.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        let xaxis = chart1.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.cities)
        xaxis.granularity = 1
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = chart1.leftAxis
        yaxis.spaceTop = 0.3
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        chart1.rightAxis.enabled = false
    }
    
    private func configuraData(){
        karachiData.label = "Karachi"
        lahoreData.label = "Lahore"
        islamabadData.label = "Islamabad"
        rawalpindiData.label = "Rawalpindi"
        chart.noDataText = "Loading..."
        chart1.noDataText = "Loading"
        
        updateChart()
    }
    
    private func updateChart(){
        getAnalyticsData().getCrimeCounts(completion: {(error,data) in
            if let err = error{
                self.chart.noDataText = err
            }else{
                let d = data?["data1"] as! [Double]
                let _d = data?["data2"] as! [String:Any]
                let crime = _d["crime"] as! [Double]
                let complaints = _d["complaints"] as! [Double]
                let missing = _d["missing"] as! [Double]

                var dataEntries: [BarChartDataEntry] = []
                var dataEntries1: [BarChartDataEntry] = []
                var dataEntries2: [BarChartDataEntry] = []
                
                for i in 0..<self.cities.count {
                    
                    let dataEntry = BarChartDataEntry(x: Double(i) , y: crime[i])
                    dataEntries.append(dataEntry)
                    
                    let dataEntry1 = BarChartDataEntry(x: Double(i) , y: complaints[i])
                    dataEntries1.append(dataEntry1)
                    
                    let dataEntry2 = BarChartDataEntry(x: Double(i) , y: missing[i])
                    dataEntries2.append(dataEntry2)
                }
                
                let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Crime")
                let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Complaints")
                let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "Missing Persons")
                
                let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
                chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
                chartDataSet1.colors = [UIColor(red: 30/255, green: 126/255, blue: 34/255, alpha: 1)]
                
                let chartData = BarChartData(dataSets: dataSets)
                
                let groupSpace = 0.0
                let barSpace = 0.0
                let barWidth = 0.3333
                
                let groupCount = self.cities.count
                let startYear = 0
                
                chartData.barWidth = barWidth;
                self.chart1.xAxis.axisMinimum = Double(startYear)
                let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
                
                self.chart1.xAxis.axisMaximum = 3.984//Double(startYear) + gg * Double(groupCount)
                
                print(Double(startYear) + gg * Double(groupCount))
                
                chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
                self.chart1.notifyDataSetChanged()
                self.self.chart1.data = chartData
                //background color
                self.chart1.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
                //chart animation
                self.chart1.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
                
                self.karachiData.value = d[0]
                self.lahoreData.value = d[1]
                self.islamabadData.value = d[2]
                self.rawalpindiData.value = d[3]
                self.totalDataEntries = [self.karachiData,self.lahoreData,self.islamabadData,self.rawalpindiData]
                let _chartDataSet = PieChartDataSet(entries: self.totalDataEntries, label: nil)
                let _chartData = PieChartData(dataSet: _chartDataSet)
                _chartDataSet.colors = [.red,.orange,.darkGray,.blue]
                self.chart.centerAttributedText = NSAttributedString(string: "Crime Distribution")
                self.chart.data = _chartData
            }
            
        })
    }
    
}
