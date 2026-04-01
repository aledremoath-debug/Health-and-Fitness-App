'use client';

import React, { useState, useEffect } from 'react';
import { User, Activity, Target, Utensils, Ruler, Weight, Calendar } from 'lucide-react';
import { useUser } from '@/context/UserContext';

const FormUserData = ({ onCalculate, initialData }) => {
    const { t } = useUser();
    const [formData, setFormData] = useState({
        age: 25,
        gender: 'male',
        weight: 70,
        height: 170,
        activityLevel: 'moderate',
        dietType: 'default',
        goal: 'maintain'
    });

    useEffect(() => {
        if (initialData) {
            setFormData({
                age: initialData.age,
                gender: initialData.gender,
                weight: initialData.weight,
                height: initialData.height,
                activityLevel: initialData.activityLevel,
                dietType: initialData.dietType,
                goal: initialData.goal
            });
        }
    }, [initialData]);

    const handleChange = (e) => {
        const { name, value } = e.target;
        const finalValue = ['age', 'weight', 'height'].includes(name) ? Number(value) : value;
        setFormData(prev => ({ ...prev, [name]: finalValue }));
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        onCalculate(formData);
    };

    const inputClasses = "w-full bg-white/5 border border-white/5 rounded-2xl px-5 py-4 text-main font-bold focus:outline-none focus:ring-2 focus:ring-blue-500/50 transition-all ltr:text-left text-sm placeholder:text-dim";
    const labelClasses = "block text-dim text-[10px] font-black uppercase tracking-widest mb-3 flex items-center gap-2 px-1";

    return (
        <form onSubmit={handleSubmit} className="theme-card p-8 relative overflow-hidden group">
            <div className="absolute -top-24 -right-24 w-48 h-48 bg-blue-500/5 blur-3xl rounded-full group-hover:bg-blue-500/10 transition-all duration-700" />

            <div className="flex items-center gap-3 mb-8 pb-6 border-b border-white/5">
                <div className="p-3 bg-blue-500/10 rounded-2xl">
                    <Activity className="text-blue-500" size={24} />
                </div>
                <div>
                    <h3 className="text-xl font-black text-main tracking-tight">{t.language === 'ar' ? 'تعديل البيانات' : 'Update Metrics'}</h3>
                    <p className="text-dim text-[10px] font-bold uppercase tracking-widest">Real-time Analysis</p>
                </div>
            </div>

            <div className="space-y-6">
                <div className="grid grid-cols-2 gap-6">
                    <div>
                        <label className={labelClasses}><Calendar size={14} /> {t.age}</label>
                        <input type="number" name="age" value={formData.age} onChange={handleChange} className={inputClasses} placeholder="25" />
                    </div>
                    <div>
                        <label className={labelClasses}><User size={14} /> {t.gender}</label>
                        <select name="gender" value={formData.gender} onChange={handleChange} className={inputClasses}>
                            <option value="male" className="bg-slate-900 text-white">{t.male}</option>
                            <option value="female" className="bg-slate-900 text-white">{t.female}</option>
                        </select>
                    </div>
                </div>

                <div className="grid grid-cols-2 gap-6">
                    <div>
                        <label className={labelClasses}><Ruler size={14} /> {t.height}</label>
                        <input type="number" name="height" value={formData.height} onChange={handleChange} className={inputClasses} placeholder="170" />
                    </div>
                    <div>
                        <label className={labelClasses}><Weight size={14} /> {t.weight}</label>
                        <input type="number" name="weight" value={formData.weight} onChange={handleChange} className={inputClasses} placeholder="70" />
                    </div>
                </div>

                <div>
                    <label className={labelClasses}><Activity size={14} /> {t.activityLevel}</label>
                    <select name="activityLevel" value={formData.activityLevel} onChange={handleChange} className={inputClasses}>
                        <option value="sedentary" className="bg-slate-900 text-white">Sedentary</option>
                        <option value="light" className="bg-slate-900 text-white">Lightly Active</option>
                        <option value="moderate" className="bg-slate-900 text-white">Moderately Active</option>
                        <option value="active" className="bg-slate-900 text-white">Very Active</option>
                    </select>
                </div>

                <div>
                    <label className={labelClasses}><Utensils size={14} /> {t.dietType}</label>
                    <select name="dietType" value={formData.dietType} onChange={handleChange} className={inputClasses}>
                        <option value="default" className="bg-slate-900 text-white">Balanced</option>
                        <option value="keto" className="bg-slate-900 text-white">Keto Diet</option>
                        <option value="vegan" className="bg-slate-900 text-white">Vegan Diet</option>
                    </select>
                </div>
            </div>

            <button type="submit" className="w-full mt-10 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-black py-5 rounded-[2rem] shadow-xl shadow-blue-500/30 transform transition-all active:scale-[0.98] uppercase tracking-widest text-[11px]">
                {t.calculate}
            </button>
        </form>
    );
};

export default FormUserData;
