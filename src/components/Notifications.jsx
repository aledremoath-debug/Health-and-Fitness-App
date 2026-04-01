'use client';

import React, { useState, useEffect } from 'react';
import { Bell, X, Info, Droplets, Dumbbell } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

const Notifications = () => {
    const [notifications, setNotifications] = useState([
        { id: 1, type: 'water', message: 'حان موقت شرب الماء! حافظ على رطوبة جسمك.', icon: <Droplets className="text-blue-500" /> },
        { id: 2, type: 'exercise', message: 'متبقي لك 30 دقيقة من تمرين اليوم.', icon: <Dumbbell className="text-indigo-500" /> }
    ]);

    const removeNotification = (id) => {
        setNotifications(prev => prev.filter(n => n.id !== id));
    };

    return (
        <div className="fixed bottom-6 right-6 z-50 w-80 space-y-3">
            <AnimatePresence>
                {notifications.map((n) => (
                    <motion.div
                        key={n.id}
                        initial={{ opacity: 0, x: 100, scale: 0.9 }}
                        animate={{ opacity: 1, x: 0, scale: 1 }}
                        exit={{ opacity: 0, scale: 0.9, transition: { duration: 0.2 } }}
                        className="bg-slate-900/80 backdrop-blur-2xl border border-white/10 p-4 rounded-2xl shadow-2xl flex gap-4 items-start"
                    >
                        <div className="p-2 bg-white/5 rounded-xl">
                            {n.icon}
                        </div>
                        <div className="flex-1">
                            <div className="flex justify-between items-center mb-1">
                                <span className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">{n.type}</span>
                                <button onClick={() => removeNotification(n.id)} className="text-slate-500 hover:text-white transition-colors">
                                    <X size={14} />
                                </button>
                            </div>
                            <p className="text-white text-xs leading-relaxed">{n.message}</p>
                        </div>
                    </motion.div>
                ))}
            </AnimatePresence>
        </div>
    );
};

export default Notifications;
