import SwiftUI
import Playgrounds

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

//all variables/constants are declared and are mutable
var currentTemp = 80
let monLow = 25
let tueLow = 90
let wedLow = 62
let thuLow = 100
let friLow = 95

let monHigh = 100
let tueHigh = 84
let wedHigh = 90
let thuHigh = 40
let friHigh = 60

let monRain = true
let tueRain = true
let wedRain = true
let thuRain = true
let friRain = true

//values for avglow and avghigh can be calculated
let avgLow = (monLow + tueLow + wedLow + thuLow + friLow)/5
let avgHigh = (monHigh + tueHigh + wedHigh + thuHigh + friHigh)/5

//a function was created to account for all rainy days, since boolean variables were declared above, we can use the values of true or false in the if/else statements to iterate and add 1 to the counter of rainy days if the bool value is true. itll add the total of all 5 days
var totalRainyDays: Int {
    var rainyDays = 0
    if monRain == true {
        rainyDays += 1
    }
    if tueRain == true {
        rainyDays += 1
    }
    if wedRain == true {
        rainyDays += 1
    }
    if thuRain == true {
        rainyDays += 1
    }
    if friRain == true {
        rainyDays += 1
    }
    return rainyDays
}
//this will create a new function that creates a new variable assuming all days will be sunny, giving it the value of 5 and then subtractinf the number of rainy days from previous function to give the total number of days that would be sunny
var totalSunnyDays: Int {
    var sunnyDays = 5
    return sunnyDays - totalRainyDays
}
//if tue

struct ContentView: View {
    @State private var isPanePresented = false
    var body: some View {
        ZStack {
            LinearGradient(colors: gradientColors, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea() //lets background fit entire screen
            Image("sun")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .padding(.bottom, 500)
                .opacity(0.6)
            ScrollView {
                VStack {//aligns all elements
                    VStack {
                        Text("Weather")
                            .font(.custom("Montserrat Black", size: 90))
                            .padding(.bottom,60)
                        HStack (spacing: 160){
                            Text("San Jose")
                                .font(.custom("Montserrat Black", size:40))
                            Text("\(currentTemp)°")
                                .font(.custom("Montserrat Black", size:40))
                        }
                        HStack (spacing: 75){
                            Text("Sunny days: \(totalSunnyDays)")
                                .font(.custom("Montserrat Black", size:25))
                            Text("Avg High: \(avgHigh)°")
                                .font(.custom("Montserrat Black", size:25))
                        }
                        HStack (spacing: 145){
                            Text("Rainy days: \(totalRainyDays)")
                                .font(.custom("Montserrat Black", size:20))
                                .foregroundStyle(Color.secondary)
                            Text("Avg Low: \(avgLow)°")
                                .font(.custom("Montserrat Black", size:20))
                                .foregroundStyle(Color.secondary)
                        }
                    }
                    FullDayForecast(day: "Mon", isRainy: monRain, high: monHigh, low: monLow)
                        .onTapGesture {
                            isPanePresented = true
                        }
                    FullDayForecast(day: "Tue", isRainy: tueRain, high: tueHigh, low: tueLow)
                    FullDayForecast(day: "Wed", isRainy: wedRain, high: wedHigh, low: wedLow)
                    FullDayForecast(day: "Thu", isRainy: thuRain, high: thuHigh, low: thuLow)
                    FullDayForecast(day: "Fri", isRainy: friRain, high: friHigh, low: friLow)
                }
            }
        }
    }
}

struct FullDayForecast: View {
    //create constants for each parameter
    let day: String
    let isRainy: Bool
    let high: Int
    let low: Int
    
    @State private var isExpanded = false
    
    //return the correct icon based on conditions
    var iconName: String {
        if isRainy {
            return "cloud.rain.fill"
        } else {
            return "sun.max.fill"
        }
    }
//returns correct color icon based on condition
    var iconColor: Color {
        if isRainy {
            return Color.blue
        } else {
            return Color.yellow
        }
    }
    
    var body: some View {
    //lays out each box
        VStack (spacing: 0) {
            HStack {
                Text(day)
                    .font(.custom("Montserrat Black", size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                Image(systemName: iconName)
                    .foregroundColor(iconColor)
                    .font(.largeTitle)
                    .padding()
                VStack (alignment: .trailing){
                    Text("High: \(high)°")
                        .fontWeight(Font.Weight.semibold)
                        .font(.custom("Montserrat Black", size: 20))
                        .padding(.trailing)
                    Text("Low: \(low)°")
                        .font(.custom("Montserrat Black", size: 18))
                        .fontWeight(Font.Weight.medium)
                        .foregroundStyle(Color.secondary)
                        .padding(.trailing)
                }
            }
            .frame(height: 90)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
            
            //this is the pane, create variables to then plug them into the group to add more data
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                        .padding(.horizontal)
                    Group {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0...11, id: \.self) { hour in
                                    if hour == 0 {
                                        VStack {
                                            Text("12AM")
                                                .padding(.trailing, 3)
                                            Image(systemName: "align.vertical.top")
                                            Text("\(Int.random(in: 60...70))°")
                                        }
                                    } else {
                                        VStack {
                                            Text("\(hour)AM")
                                                .padding(.trailing, 3)
                                            Image(systemName: "align.vertical.top")
                                            Text("\(Int.random(in: 60...70))°")
                                        }
                                    }
                                }
                                ForEach(0...11, id: \.self) { hour in
                                    if hour == 0 {
                                        VStack {
                                            Text("12PM")
                                                .padding(.trailing, 3)
                                            Image(systemName: "align.vertical.top")
                                            Text("\(Int.random(in: 60...70))°")
                                        }
                                    } else {
                                        VStack {
                                            Text("\(hour)PM")
                                                .padding(.trailing, 3)
                                            Image(systemName: "align.vertical.top")
                                            Text("\(Int.random(in: 60...70))°")
                                        }
                                    }
                                }
                            }
                            .padding(.bottom)
                            
                        }
                    }
                    .font(.custom("Monserrat Black", size: 16))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.bottom, 15)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .frame(width: 350) //creates box dimensions
        //rounds out the edges
        //.overlay(RoundedRectangle(cornerRadius: 10)  .stroke(Color.black))
        .background(Color("BoxColor")) //changes color of background each frame
        .cornerRadius(10) // adds the rounded edges to the background color(if not itll be a square)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y:10) //adds shadow bottom-right
        .shadow(color:Color.white.opacity(0.2), radius: 10, x: -5, y: -15) //adds light top-left
        .padding(5)//padding inbetween boxes
    }
}




// Bottom Pane

//struct BottomPanelView: View {
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("This is your bottom pane!")
//                .font(.title2)
//                .bold()
//                
//            Button("Close") {
//                dismiss()
//            }
//            .buttonStyle(.borderedProminent)
//            }
//            .padding()
//        }
//    }


#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
