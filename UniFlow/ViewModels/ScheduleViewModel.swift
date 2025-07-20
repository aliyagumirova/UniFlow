//
//  ScheduleViewModel.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import Foundation

final class ScheduleViewModel: ObservableObject {
    private let networkService: NetworkProtocol
    private let eventManager: ManagerProtocol

    @Published private(set) var events: [Event] = []
    @Published var selectedDate: Date = Date()
    
    init(networkService: NetworkProtocol, eventManager: ManagerProtocol) {
        self.networkService = networkService
        self.eventManager = eventManager
        loadEvents()
    }

    func loadEvents() {
           // Сначала пробуем загрузить из базы
           eventManager.fetch(of: Event.self) { [weak self] localEvents in
               guard let self = self else { return }
               if localEvents.isEmpty {
                   // Если пусто — грузим из сети
                   self.networkService.getData(of: EventsDTO.self, endpoint: .getEvents) { result in
                       switch result {
                       case .success(let dtos):
                           // Сохраняем в базу
                           self.eventManager.createEvent(from: dtos) { saveResult in
                               switch saveResult {
                               case .success(let savedEvents):
                                   DispatchQueue.main.async {
                                       self.events = savedEvents
                                   }
                               case .failure(let error):
                                   print("Save error: \(error)")
                               }
                           }
                       case .failure(let error):
                           print("Network error: \(error)")
                       }
                   }
               } else {
                   // Если не пусто — используем локальные
                   DispatchQueue.main.async {
                       self.events = localEvents
                   }
               }
           }
       }

    var lessonsForSelectedDate: [Event] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selected = formatter.string(from: selectedDate)
        return events.filter { $0.date == selected }
    }
}

