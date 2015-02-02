% TestSplitBregman class
lam = 0.1;
mu = 1;
nd = 128;
rps = 1;
fps = 64;
zmax = 1;
vtab = 1;
NTrue = 128;
NRecon = 128;
cbct = Operators.ConeBeamScanner('helix',nd,nd,[],zmax,rps,vtab,fps);
A = @(x)cbct.apply(x);
At = @(x)cbct.applyAdjoint(x,[NRecon,NRecon,NRecon]);

% Generate phantom, projection and initial guess
uTrue = DataTypes.ObjectData(3,single(phantom3d(NTrue)),[2,2,2]);
u0 = DataTypes.ObjectData(3,single(zeros(NRecon,NRecon,NRecon)),[2,2,2]);
f = A(uTrue);

% Create framelet transforms 
framelet = Transforms.FrameletSystem(3,'linear',1);
W = @(x)(x.frameletTransform(framelet));
Wt = @(x)(DataTypes.ObjectData(3,x.adjointFrameletTransform(framelet),[2,2,2]));

SBSolver = Optimizers.SplitBregman(A,At,W,Wt,lam,mu,f,u0,20,20);

u = SBSolver.solveSplitBregman();