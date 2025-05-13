import numpy as np
import matplotlib.pyplot as plt

v0 = 1.0        # initial constant speed
lr = 2.0        
dt = 0.05       # time step (s)
T = 10          # total simulation time (s)
n_steps = int(T / dt)
a = 0.0
b_values = [-0.2, 0, 0.2]

plt.figure(figsize=(6,6))

for b in b_values:
    # initial state: x=0, y=0, psi=0, v=v0, beta=0
    x = 0.0
    y = 0.0
    psi = 0.0
    v = v0
    beta = 0.0
    
    traj = []
    for _ in range(n_steps):
        
        noise_std = 0.4 #desviacion
        b_chaotic = b + np.random.normal(0, noise_std)
        #b_chaotic = b  
        # Model equations with chaos in dbeta
        dx = v * np.cos(psi + beta) * dt
        dy = v * np.sin(psi + beta) * dt
        dpsi = (v / lr) * np.sin(beta) * dt
        dv = a * dt
        dbeta = b_chaotic * dt
        
        # Update state
        x += dx
        y += dy
        psi += dpsi
        v += dv
        beta += dbeta
        
        traj.append((y, psi))
    
    traj = np.array(traj)
    plt.plot(traj[:,0], traj[:,1], label=f"b = {b}")

plt.xlabel('Lateral Position (y)')
plt.ylabel('Heading Angle (ψ)')
plt.title('Phase Diagram: Extended Kinematic Bicycle Model')
plt.legend(title='Slip-Angle Rate b')
plt.grid(True)
plt.tight_layout()
plt.show()
