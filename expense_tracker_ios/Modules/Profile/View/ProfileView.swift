//
//  ProfileView.swift
//  expense_tracker_ios
//
//  Created by Touch and Solve on 3/5/26.
//

import SwiftUI

struct ProfileView: View, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol?
    
    // Point to the shared instance so data doesn't wipe on nav
    @ObservedObject var presenterState = ProfilePresenter.shared

    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.97, green: 0.98, blue: 0.99)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                navigationHeader
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        profileHeaderCard
                        menuSection
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                }
                .refreshable {
                    presenterState.refreshData()
                }
            }
            
            // This will only show on the very first fetch or during logout
            if presenterState.isLoading {
                loadingOverlay
            }
        }
        .onAppear {
            // Re-bind the interactor/router from the assembly if needed
            if let p = presenter as? ProfilePresenter {
                presenterState.interactor = p.interactor
                presenterState.router = p.router
                p.interactor?.presenter = presenterState
            }
            presenterState.viewDidLoad()
        }
        .alert("Account Error", isPresented: $presenterState.showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(presenterState.errorMessage ?? "An unexpected error occurred.")
        }
    }

    // ... (Keep the rest of your navigationHeader, profileHeaderCard, etc. exactly as they were)
    
    private var navigationHeader: some View {
        HStack {
            Button(action: {
                withAnimation { AppStateManager.shared.currentRoute = .home }
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .bold))
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.05), radius: 5)
            }
            .foregroundColor(.black)
            Spacer()
            Text("My Profile").font(.system(size: 17, weight: .bold))
            Spacer()
            Color.clear.frame(width: 32)
        }
        .padding(.horizontal, 20)
        .frame(height: 56)
    }

    private var profileHeaderCard: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(Color.indigo.opacity(0.1))
                .frame(width: 80, height: 80)
                .overlay(Image(systemName: "person.fill").font(.system(size: 32)).foregroundColor(.indigo))
            
            VStack(spacing: 2) {
                if presenterState.name.isEmpty && presenterState.isLoading {
                    RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.1)).frame(width: 100, height: 16)
                } else {
                    Text(presenterState.name).font(.system(size: 20, weight: .bold))
                }
                Text(presenterState.email).font(.system(size: 14)).foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.02), radius: 10, x: 0, y: 5)
    }

    private var menuSection: some View {
        VStack(spacing: 10) {
            ProfileMenuRow(icon: "gearshape", title: "Settings", color: .blue)
            ProfileMenuRow(icon: "bell", title: "Notifications", color: .orange)
            ProfileMenuRow(icon: "questionmark.circle", title: "Help & Support", color: .teal)
            ProfileMenuRow(icon: "rectangle.portrait.and.arrow.right", title: "Logout", color: .red, isDestructive: true) {
                presenterState.didTapLogout()
            }
        }
    }

    private var loadingOverlay: some View {
        Color.black.opacity(0.15)
            .ignoresSafeArea()
            .overlay(
                ProgressView()
                    .padding(20)
                    .background(BlurView(style: .systemUltraThinMaterialDark))
                    .cornerRadius(12)
            )
    }

    func showProfile(name: String, email: String) {}
    func showError(_ message: String) {}
}

// MARK: - Subviews

struct ProfileMenuRow: View {
    let icon: String
    let title: String
    let color: Color
    var isDestructive: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(color.opacity(0.1))
                        .frame(width: 32, height: 32)
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isDestructive ? .red : Color.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.gray.opacity(0.3))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
