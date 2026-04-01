'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useUser } from '@/context/UserContext';
import Navbar from '@/components/Navbar';
import {
    LayoutDashboard,
    BarChart3,
    Settings as SettingsIcon,
    ChevronLeft,
    User,
    Bell,
    Shield,
    Moon,
    Globe,
    Check,
    Save,
    Heart
} from 'lucide-react';

export default function Settings() {
    const { userData, updateUserData, t } = useUser();
    const [activeTab, setActiveTab] = useState('profile');
    const [savedFeedback, setSavedFeedback] = useState(false);

    const menuItems = [
        { id: 'profile', icon: <User size={20} />, label: t.profile },
        { id: 'notifications', icon: <Bell size={20} />, label: t.notifications },
        { id: 'security', icon: <Shield size={20} />, label: t.security },
        { id: 'appearance', icon: <Moon size={20} />, label: t.appearance },
        { id: 'language', icon: <Globe size={20} />, label: t.language },
    ];

    const handleSave = () => {
        setSavedFeedback(true);
        setTimeout(() => setSavedFeedback(false), 2000);
    };

    const toggleNotification = (key) => {
        updateUserData({
            notifications: {
                ...userData.notifications,
                [key]: !userData.notifications[key]
            }
        });
    };

    return (
        <main className="min-h-screen">
            <Navbar />

            <div className="pt-32 pb-24 px-4 md:px-12 max-w-[1400px] mx-auto" suppressHydrationWarning>
                <div className="flex justify-between items-end mb-12">
                    <div>
                        <h1 className="text-5xl font-black tracking-tighter mb-2">{t.settings}</h1>
                        <p className="text-dim text-sm font-medium">Fine-tune your vitality experience.</p>
                    </div>
                    {savedFeedback && (
                        <div className="flex items-center gap-2 text-emerald-500 font-black uppercase tracking-widest text-xs animate-in fade-in slide-in-from-right-4 pb-2">
                            <Check size={18} /> {t.savedSuccess}
                        </div>
                    )}
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-4 gap-12">
                    {/* Sidebar */}
                    <div className="lg:col-span-1 space-y-3">
                        {menuItems.map((item) => (
                            <button
                                key={item.id}
                                onClick={() => setActiveTab(item.id)}
                                className={`w-full flex items-center gap-4 px-6 py-5 rounded-[2rem] transition-all border ${activeTab === item.id
                                    ? "bg-blue-600 text-white shadow-xl shadow-blue-500/20 border-blue-500"
                                    : "bg-white/5 text-dim border-transparent hover:bg-white/10 hover:text-main"
                                    }`}
                            >
                                {item.icon}
                                <span className="font-black text-xs uppercase tracking-widest">{item.label}</span>
                            </button>
                        ))}
                    </div>

                    {/* Content Area */}
                    <div className="lg:col-span-3 theme-card p-10 min-h-[600px] relative overflow-hidden">

                        {/* Profile Tab */}
                        {activeTab === 'profile' && (
                            <div className="space-y-10 animate-in fade-in slide-in-from-bottom-4 duration-500">
                                <div className="flex items-center gap-8 pb-10 border-b border-white/5">
                                    <div className="w-28 h-28 rounded-[2.5rem] bg-gradient-to-tr from-blue-600 to-indigo-600 p-1">
                                        <div className="w-full h-full rounded-[2.2rem] overflow-hidden bg-slate-900 flex items-center justify-center">
                                            <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${userData.name}`} className="w-full h-full object-cover" alt="" />
                                        </div>
                                    </div>
                                    <div>
                                        <h3 className="text-2xl font-black tracking-tight text-main">{userData.name}</h3>
                                        <p className="text-dim text-xs font-bold uppercase tracking-widest mt-1">Premium Health Member</p>
                                        <button className="mt-4 text-blue-500 text-xs font-black uppercase tracking-widest hover:underline transition-all">Update Avatar</button>
                                    </div>
                                </div>

                                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div className="space-y-3">
                                        <label className="text-dim text-[10px] font-black uppercase tracking-widest pr-1">Full Name</label>
                                        <input
                                            type="text"
                                            value={userData.name}
                                            onChange={(e) => updateUserData({ name: e.target.value })}
                                            className="w-full bg-white/5 border border-white/5 rounded-2xl px-5 py-4 text-main font-bold focus:outline-none focus:ring-2 focus:ring-blue-500/50 transition-all ltr:text-left"
                                        />
                                    </div>
                                    <div className="space-y-3">
                                        <label className="text-dim text-[10px] font-black uppercase tracking-widest pr-1">Email</label>
                                        <input
                                            type="email"
                                            value={userData.email}
                                            onChange={(e) => updateUserData({ email: e.target.value })}
                                            className="w-full bg-white/5 border border-white/5 rounded-2xl px-5 py-4 text-main font-bold focus:outline-none focus:ring-2 focus:ring-blue-500/50 transition-all ltr:text-left"
                                        />
                                    </div>
                                </div>

                                <div className="pt-6">
                                    <button
                                        onClick={handleSave}
                                        className="bg-blue-600 hover:bg-blue-500 text-white px-12 py-5 rounded-[2rem] font-black uppercase tracking-widest text-xs transition-all shadow-xl shadow-blue-500/30 active:scale-95 flex items-center gap-3"
                                    >
                                        <Save size={18} /> {t.saveChanges}
                                    </button>
                                </div>
                            </div>
                        )}

                        {/* Notifications Tab */}
                        {activeTab === 'notifications' && (
                            <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                                <h3 className="text-2xl font-black tracking-tight text-main mb-8">{t.notifications}</h3>
                                <div className="grid grid-cols-1 gap-4">
                                    {[
                                        { id: 'water', label: 'Hydration Engine', desc: 'Smarter alerts to keeps your body hydrated.' },
                                        { id: 'exercise', label: 'Active Performance', desc: 'Timely reminders for your peak workout slots.' },
                                    ].map((notif) => (
                                        <div key={notif.id} className="flex items-center justify-between p-6 bg-white/5 rounded-[2rem] border border-white/5 group hover:border-blue-500/20 transition-all">
                                            <div>
                                                <h4 className="font-black text-main text-sm uppercase tracking-tight">{notif.label}</h4>
                                                <p className="text-dim text-xs mt-1 font-medium">{notif.desc}</p>
                                            </div>
                                            <button
                                                onClick={() => toggleNotification(notif.id)}
                                                className={`w-14 h-7 rounded-full transition-all relative flex items-center px-1 ${userData.notifications[notif.id] ? 'bg-blue-600' : 'bg-slate-700'}`}
                                            >
                                                <div className={`w-5 h-5 rounded-full bg-white transition-all shadow-sm ${userData.notifications[notif.id] ? 'translate-x-7 rtl:-translate-x-7' : 'translate-x-0'}`} />
                                            </button>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        )}

                        {/* Appearance Tab */}
                        {activeTab === 'appearance' && (
                            <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                                <h3 className="text-2xl font-black tracking-tight text-main mb-8">{t.appearance}</h3>
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div
                                        onClick={() => updateUserData({ theme: 'dark' })}
                                        className={`p-8 bg-white/5 border rounded-[2.5rem] transition-all cursor-pointer group ${userData.theme === 'dark' ? 'border-blue-500/50 ring-1 ring-blue-500/50 bg-blue-500/5' : 'border-white/5 opacity-50'}`}
                                    >
                                        <div className="w-full h-32 bg-slate-950 rounded-2xl mb-6 p-4 relative overflow-hidden border border-white/10">
                                            <div className="w-1/2 h-3 bg-blue-600 rounded-full mb-3" />
                                            <div className="w-3/4 h-3 bg-white/10 rounded-full" />
                                        </div>
                                        <p className="font-black text-center text-xs uppercase tracking-widest">{t.darkMode}</p>
                                    </div>
                                    <div
                                        onClick={() => updateUserData({ theme: 'light' })}
                                        className={`p-8 bg-white/5 border rounded-[2.5rem] transition-all cursor-pointer group ${userData.theme === 'light' ? 'border-blue-500/50 ring-1 ring-blue-500/50 bg-blue-500/5' : 'border-white/5 opacity-50'}`}
                                    >
                                        <div className="w-full h-32 bg-white rounded-2xl mb-6 p-4 relative overflow-hidden border border-slate-200">
                                            <div className="w-1/2 h-3 bg-blue-600 rounded-full mb-3" />
                                            <div className="w-3/4 h-3 bg-slate-200 rounded-full" />
                                        </div>
                                        <p className="font-black text-center text-xs uppercase tracking-widest">{t.lightMode}</p>
                                    </div>
                                </div>
                            </div>
                        )}

                        {/* Language Tab */}
                        {activeTab === 'language' && (
                            <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                                <h3 className="text-2xl font-black tracking-tight text-main mb-8">{t.language}</h3>
                                <div className="grid grid-cols-1 gap-4">
                                    {[
                                        { id: 'ar', label: 'العربية', flag: '🇸🇦' },
                                        { id: 'en', label: 'English', flag: '🇺🇸' }
                                    ].map((lang) => (
                                        <div
                                            key={lang.id}
                                            onClick={() => updateUserData({ language: lang.id })}
                                            className={`flex items-center justify-between p-6 bg-white/5 rounded-[2rem] border transition-all cursor-pointer group ${userData.language === lang.id ? 'border-blue-500/50 bg-blue-500/5' : 'border-white/5'}`}
                                        >
                                            <div className="flex items-center gap-5">
                                                <span className="text-3xl filter grayscale group-hover:grayscale-0 transition-all">{lang.flag}</span>
                                                <span className="font-black uppercase text-xs tracking-widest">{lang.label}</span>
                                            </div>
                                            {userData.language === lang.id && (
                                                <div className="p-2 bg-blue-500 rounded-xl text-white">
                                                    <Check size={18} />
                                                </div>
                                            )}
                                        </div>
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </main>
    );
}
