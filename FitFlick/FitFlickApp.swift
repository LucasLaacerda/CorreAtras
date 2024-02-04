//
//  FitFlickApp.swift
//  FitFlick
//
//  Created by Lucas Lacerda on 03/02/24.
//

import SwiftUI
import BackgroundTasks

@main
struct FitFlickApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
                    SplashView()
                        .onAppear {
                            // Adicione qualquer lógica necessária para a SplashView
                            // Por exemplo, pode ser um temporizador para exibir a Splash por um tempo definido antes de navegar para a tela de login.
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                // 2 segundos de atraso como exemplo
                                NavigateToLogin()
                            }
                        }
                }
    }
    
    func NavigateToLogin() {
        let loginView = LoginView()
        let contentView = loginView
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            // Você pode passar dados necessários através de um environmentObject se necessário
            .navigationTitle("") // Para ocultar o título da navegação de volta na tela de login

        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: contentView)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configurar o BackgroundTasks
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.yourapp.backgroundTask", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }

    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.yourapp.backgroundTask")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // Agendar um refresh a cada 15 minutos

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Erro ao agendar o refresh em segundo plano: \(error)")
        }
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh() // Agendar o próximo refresh

        // Adicione aqui a lógica para continuar a contagem do tempo
        // Certifique-se de usar a thread principal para atualizações de interface do usuário

        task.setTaskCompleted(success: true)
    }
}

