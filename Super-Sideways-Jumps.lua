import React, { useState, useEffect } from 'react';

export default function SidewaysJumpsGUI() {
  const [isEnabled, setIsEnabled] = useState(true);
  const [isAutoDash, setIsAutoDash] = useState(true);
  const [distance, setDistance] = useState(50);
  const [speedLevel, setSpeedLevel] = useState(5);
  const [isMinimized, setIsMinimized] = useState(false);
  const [nextDirection, setNextDirection] = useState('left');

  const DISTANCE_STEP = 25;
  const MIN_DISTANCE = 1;

  const speedLevels = [
    { name: 'SLOW', interval: 100, color: 'text-blue-400' },
    { name: 'FAST', interval: 50, color: 'text-green-400' },
    { name: 'VERY FAST', interval: 20, color: 'text-yellow-400' },
    { name: 'EXTREME', interval: 10, color: 'text-orange-400' },
    { name: 'MAX', interval: 5, color: 'text-red-400' },
    { name: 'BEYOND MAX', interval: 2, color: 'text-red-500' },
    { name: 'INFINITE', interval: 1, color: 'text-purple-500' },
    { name: 'BEYOND INFINITE', interval: 0, color: 'text-pink-500' },
    { name: 'REALITY BROKEN', interval: 0, color: 'text-white animate-pulse' },
    { name: 'CHAOS MODE', interval: 0, color: 'text-red-600 animate-bounce' },
  ];

  const currentSpeed = speedLevels[speedLevel];
  
  const getSpeedText = () => currentSpeed.name;

  const handleJump = (direction) => {
    if (!isEnabled) return;
    // Visual feedback with shake effect at high speeds
    const btn = document.getElementById(direction === 'left' ? 'leftBtn' : 'rightBtn');
    if (btn) {
      btn.style.transform = 'scale(0.95)';
      setTimeout(() => btn.style.transform = 'scale(1)', 50);
    }
  };

  // Ultra-fast auto dash using requestAnimationFrame for speeds beyond infinite
  useEffect(() => {
    let animationId;
    let lastTime = 0;
    
    const animate = (currentTime) => {
      if (isEnabled && isAutoDash) {
        const interval = currentSpeed.interval;
        
        if (interval === 0 || currentTime - lastTime >= interval) {
          setNextDirection(prev => prev === 'left' ? 'right' : 'left');
          lastTime = currentTime;
        }
        
        animationId = requestAnimationFrame(animate);
      }
    };
    
    if (isEnabled && isAutoDash) {
      animationId = requestAnimationFrame(animate);
    }
    
    return () => {
      if (animationId) cancelAnimationFrame(animationId);
    };
  }, [isEnabled, isAutoDash, currentSpeed.interval]);

  if (isMinimized) {
    return (
      <div className="fixed bottom-4 left-1/2 transform -translate-x-1/2 z-50 touch-manipulation">
        <div className="bg-black rounded-lg shadow-2xl p-3 flex items-center justify-between gap-3" style={{ width: '280px' }}>
          <h1 className="text-red-500 font-bold text-lg">Super's Sideways Jumps</h1>
          <button
            onClick={() => setIsMinimized(false)}
            className="w-8 h-8 bg-gray-700 text-white rounded font-bold text-lg active:bg-gray-600"
          >
            +
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="fixed bottom-4 left-1/2 transform -translate-x-1/2 z-50 touch-manipulation select-none">
      <div className={`bg-black rounded-2xl shadow-2xl p-4 w-[95vw] max-w-md ${
        speedLevel >= 8 ? 'animate-pulse shadow-red-500/50' : ''
      } ${
        speedLevel === 9 ? 'animate-bounce' : ''
      }`}>
        {/* Header */}
        <div className="flex items-center justify-between mb-4">
          <h1 className={`font-bold text-xl ${
            speedLevel >= 8 ? 'text-transparent bg-clip-text bg-gradient-to-r from-red-500 via-purple-500 to-pink-500 animate-pulse' : 'text-red-500'
          }`}>
            Super's Sideways Jumps
          </h1>
          <button
            onClick={() => setIsMinimized(true)}
            className="w-8 h-8 bg-gray-700 text-white rounded font-bold text-xl active:bg-gray-600 transition-colors"
          >
            –
          </button>
        </div>

        {/* Chaos Mode Warning Banner */}
        {speedLevel === 9 && (
          <div className="mb-3 bg-gradient-to-r from-red-600 via-purple-600 to-pink-600 p-2 rounded-lg text-center animate-pulse">
            <div className="text-white font-bold text-sm animate-bounce">
              🔥 CHAOS MODE ACTIVE 🔥
            </div>
            <div className="text-xs text-white opacity-90">Reality.exe has stopped working</div>
          </div>
        )}

        {/* Toggle Buttons */}
        <div className="grid grid-cols-2 gap-3 mb-4">
          <button
            onClick={() => setIsEnabled(!isEnabled)}
            className={`h-14 rounded-xl font-bold text-lg transition-all active:scale-95 ${
              isEnabled 
                ? 'bg-red-500 text-white shadow-lg shadow-red-500/50' 
                : 'bg-gray-700 text-gray-300'
            }`}
          >
            {isEnabled ? 'ENABLED' : 'DISABLED'}
          </button>
          <button
            onClick={() => setIsAutoDash(!isAutoDash)}
            className={`h-14 rounded-xl font-bold text-sm transition-all active:scale-95 ${
              isAutoDash 
                ? 'bg-orange-500 text-white shadow-lg shadow-orange-500/50' 
                : 'bg-gray-700 text-gray-300'
            }`}
          >
            AUTO DASH: {isAutoDash ? 'ON' : 'OFF'}
          </button>
        </div>

        {/* Distance Control */}
        <div className="mb-4">
          <div className="text-red-200 font-semibold mb-2 text-center">
            Distance: {distance} studs
          </div>
          <div className="flex gap-2 items-center">
            <button
              onClick={() => setDistance(Math.max(MIN_DISTANCE, distance - DISTANCE_STEP))}
              className="flex-1 h-12 bg-gray-700 text-white rounded-xl font-bold text-2xl active:bg-gray-600 transition-colors"
            >
              −
            </button>
            <div className="flex-1 h-12 bg-gray-800 rounded-xl flex items-center justify-center text-red-400 font-bold text-xl">
              {distance}
            </div>
            <button
              onClick={() => setDistance(distance + DISTANCE_STEP)}
              className="flex-1 h-12 bg-gray-700 text-white rounded-xl font-bold text-2xl active:bg-gray-600 transition-colors"
            >
              +
            </button>
          </div>
        </div>

        {/* Speed Control */}
        <div className="mb-4">
          <div className="text-red-200 font-semibold mb-2 text-center">
            Speed: <span className={currentSpeed.color}>{getSpeedText()}</span>
          </div>
          <div className="flex gap-2 items-center">
            <button
              onClick={() => setSpeedLevel(Math.max(0, speedLevel - 1))}
              className="flex-1 h-12 bg-gray-700 text-white rounded-xl font-bold text-2xl active:bg-gray-600 transition-colors disabled:opacity-50"
              disabled={speedLevel === 0}
            >
              −
            </button>
            <div className={`flex-1 h-12 rounded-xl flex items-center justify-center font-bold text-sm ${
              speedLevel >= 7 ? 'bg-gradient-to-r from-purple-900 via-pink-900 to-red-900 animate-pulse' : 'bg-gray-800'
            }`}>
              <span className={currentSpeed.color}>{getSpeedText()}</span>
            </div>
            <button
              onClick={() => setSpeedLevel(Math.min(speedLevels.length - 1, speedLevel + 1))}
              className="flex-1 h-12 bg-gray-700 text-white rounded-xl font-bold text-2xl active:bg-gray-600 transition-colors disabled:opacity-50"
              disabled={speedLevel === speedLevels.length - 1}
            >
              +
            </button>
          </div>
          {speedLevel >= 7 && (
            <div className="text-center mt-2 text-xs text-red-500 animate-pulse font-bold">
              ⚠️ WARNING: REALITY UNSTABLE ⚠️
            </div>
          )}
        </div>

        {/* Jump Buttons */}
        <div className="grid grid-cols-2 gap-3">
          <button
            id="leftBtn"
            onClick={() => handleJump('left')}
            className={`h-24 rounded-2xl font-bold text-2xl shadow-lg transition-all ${
              speedLevel >= 8 
                ? 'bg-gradient-to-br from-purple-600 via-pink-600 to-red-600 text-white shadow-pink-500/50 animate-pulse' 
                : 'bg-gradient-to-br from-red-500 to-red-600 text-white shadow-red-500/30'
            } active:shadow-red-500/50`}
            style={{ touchAction: 'manipulation' }}
          >
            {speedLevel === 9 ? '⚡ LEFT ⚡' : '← LEFT'}
          </button>
          <button
            id="rightBtn"
            onClick={() => handleJump('right')}
            className={`h-24 rounded-2xl font-bold text-2xl shadow-lg transition-all ${
              speedLevel >= 8 
                ? 'bg-gradient-to-br from-purple-600 via-pink-600 to-red-600 text-white shadow-pink-500/50 animate-pulse' 
                : 'bg-gradient-to-br from-red-500 to-red-600 text-white shadow-red-500/30'
            } active:shadow-red-500/50`}
            style={{ touchAction: 'manipulation' }}
          >
            {speedLevel === 9 ? '⚡ RIGHT ⚡' : 'RIGHT →'}
          </button>
        </div>

        {/* Auto Dash Indicator */}
        {isEnabled && isAutoDash && (
          <div className="mt-3 text-center">
            <div className={`inline-flex items-center gap-2 px-4 py-2 rounded-full ${
              speedLevel >= 8 
                ? 'bg-gradient-to-r from-purple-900 via-pink-900 to-red-900 animate-pulse' 
                : 'bg-gray-800'
            }`}>
              <div className={`w-3 h-3 rounded-full ${
                nextDirection === 'left' 
                  ? speedLevel >= 8 ? 'bg-pink-400 animate-ping' : 'bg-red-500 animate-pulse'
                  : 'bg-gray-600'
              }`}></div>
              <span className={`text-xs font-medium ${
                speedLevel >= 8 ? 'text-white animate-pulse' : 'text-gray-400'
              }`}>
                {speedLevel >= 8 ? '⚡ HYPER DASHING ⚡' : 'AUTO DASHING'}
              </span>
              <div className={`w-3 h-3 rounded-full ${
                nextDirection === 'right' 
                  ? speedLevel >= 8 ? 'bg-pink-400 animate-ping' : 'bg-red-500 animate-pulse'
                  : 'bg-gray-600'
              }`}></div>
            </div>
            {speedLevel >= 6 && (
              <div className="mt-2 text-xs text-purple-400 font-bold animate-pulse">
                {speedLevel >= 8 ? '∞ BEYOND TIME AND SPACE ∞' : `Speed: ${currentSpeed.interval}ms`}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
