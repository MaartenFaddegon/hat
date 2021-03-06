module Hat.IO
  (Handle(),HandlePosn(),IOMode(ReadMode,WriteMode,AppendMode,ReadWriteMode)
    ,aReadMode,aWriteMode,aAppendMode,aReadWriteMode,BufferMode(NoBuffering
      ,LineBuffering,BlockBuffering),aNoBuffering,aLineBuffering,aBlockBuffering
    ,SeekMode(AbsoluteSeek,RelativeSeek,SeekFromEnd),aAbsoluteSeek,aRelativeSeek
    ,aSeekFromEnd,gstdin,gstdout,gstderr,gopenFile,aopenFile,hopenFile,ghClose
    ,ahClose,hhClose,ghFileSize,ahFileSize,hhFileSize,ghIsEOF,ahIsEOF,hhIsEOF
    ,gisEOF,ghSetBuffering,ahSetBuffering,hhSetBuffering,ghGetBuffering
    ,ahGetBuffering,hhGetBuffering,ghFlush,ahFlush,hhFlush,ghGetPosn,ahGetPosn
    ,hhGetPosn,ghSetPosn,ahSetPosn,hhSetPosn,ghSeek,ahSeek,hhSeek,ghWaitForInput
    ,ahWaitForInput,hhWaitForInput,ghReady,ahReady,hhReady,ghGetChar,ahGetChar
    ,hhGetChar,ghGetLine,ahGetLine,hhGetLine,ghLookAhead,ahLookAhead,hhLookAhead
    ,ghGetContents,ahGetContents,hhGetContents,ghPutChar,ahPutChar,hhPutChar
    ,ghPutStr,ahPutStr,hhPutStr,ghPutStrLn,ahPutStrLn,hhPutStrLn,ghPrint,ahPrint
    ,hhPrint,ghIsOpen,ahIsOpen,hhIsOpen,ghIsClosed,ahIsClosed,hhIsClosed
    ,ghIsReadable,ahIsReadable,hhIsReadable,ghIsWritable,ahIsWritable
    ,hhIsWritable,ghIsSeekable,ahIsSeekable,hhIsSeekable,gisAlreadyExistsError
    ,aisAlreadyExistsError,hisAlreadyExistsError,gisDoesNotExistError
    ,aisDoesNotExistError,hisDoesNotExistError,gisAlreadyInUseError
    ,aisAlreadyInUseError,hisAlreadyInUseError,gisFullError,aisFullError
    ,hisFullError,gisEOFError,aisEOFError,hisEOFError,gisIllegalOperation
    ,aisIllegalOperation,hisIllegalOperation,gisPermissionError
    ,aisPermissionError,hisPermissionError,gisUserError,aisUserError
    ,hisUserError,gioeGetErrorString,aioeGetErrorString,hioeGetErrorString
    ,gioeGetHandle,aioeGetHandle,hioeGetHandle,gioeGetFileName,aioeGetFileName
    ,hioeGetFileName,gtry,atry,htry,gbracket,abracket,hbracket,gbracket_
    ,abracket_,hbracket_,IO(),FilePath(),IOError(),gioError,aioError,hioError
    ,guserError,auserError,huserError,gcatch,acatch,hcatch,ginteract,ainteract
    ,hinteract,gputChar,aputChar,hputChar,gputStr,aputStr,hputStr,gputStrLn
    ,aputStrLn,hputStrLn,gprint,aprint,hprint,ggetChar,ggetLine,ggetContents
    ,greadFile,areadFile,hreadFile,gwriteFile,awriteFile,hwriteFile,gappendFile
    ,aappendFile,happendFile,greadIO,areadIO,hreadIO,greadLn) where

import qualified Hat.PreludeBasic 
import qualified Prelude 
import Hat.Hack 
import qualified Hat.Hat as T 
import Hat.Hat  (WrapVal(wrapVal))
import Hat.Prelude 
import Hat.Ix  (Ix(grange,gindex,ginRange,srange,sindex,sinRange))
import Hat.PreludeBuiltinTypes 
import System.IO  (Handle(),HandlePosn())
import qualified System.IO as IO 
import qualified System.IO.Error as Error 
import Hat.IOBuiltinTypes 
import Hat.IOBuiltin 

gprimHandleEq ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (T.Fun Handle Bool))

gprimHandleEq pprimHandleEq p =
  T.ufun2 aprimHandleEq pprimHandleEq p hprimHandleEq

hprimHandleEq z1primHandleEq z2primHandleEq kprimHandleEq =
  fromBool kprimHandleEq
    ((toHandle kprimHandleEq z1primHandleEq)
      Prelude.==
      (toHandle kprimHandleEq z2primHandleEq))

gprimHandleShowsPrec ::
  T.RefSrcPos ->
    T.RefExp -> T.R (T.Fun Int (T.Fun Handle (T.Fun String String)))

gprimHandleShowsPrec pprimHandleShowsPrec p =
  T.ufun3 aprimHandleShowsPrec pprimHandleShowsPrec p hprimHandleShowsPrec

hprimHandleShowsPrec z1primHandleShowsPrec z2primHandleShowsPrec
  z3primHandleShowsPrec kprimHandleShowsPrec =
  fromString kprimHandleShowsPrec
    (Prelude.showsPrec (T.toInt kprimHandleShowsPrec z1primHandleShowsPrec)
      (toHandle kprimHandleShowsPrec z2primHandleShowsPrec)
      (toString kprimHandleShowsPrec z3primHandleShowsPrec))

instance Eq (Handle)
  where
  
  (!==) (%==) p = T.uconstUse (%==) p (|==)
  
  (|==) =
    T.uconstDef T.mkRoot (+&%=&=&%=$#==) (\ p -> gprimHandleEq T.mkNoSrcPos p)
  

instance Show (Handle)
  where
  
  gshowsPrec pshowsPrec p = T.uconstUse pshowsPrec p sshowsPrec
  
  sshowsPrec =
    T.uconstDef T.mkRoot a46v3v46v33showsPrec
      (\ p -> gprimHandleShowsPrec T.mkNoSrcPos p)
  

gprimHandlePosnEq ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun HandlePosn (T.Fun HandlePosn Bool))

gprimHandlePosnEq pprimHandlePosnEq p =
  T.ufun2 aprimHandlePosnEq pprimHandlePosnEq p hprimHandlePosnEq

hprimHandlePosnEq z1primHandlePosnEq z2primHandlePosnEq kprimHandlePosnEq =
  fromBool kprimHandlePosnEq
    ((toHandlePosn kprimHandlePosnEq z1primHandlePosnEq)
      Prelude.==
      (toHandlePosn kprimHandlePosnEq z2primHandlePosnEq))

instance Eq (HandlePosn)
  where
  
  (!==) (%==) p = T.uconstUse (%==) p (|==)
  
  (|==) =
    T.uconstDef T.mkRoot (+*&=&=*&=$*==)
      (\ p -> gprimHandlePosnEq T.mkNoSrcPos p)
  

gstdin :: T.RefSrcPos -> T.RefExp -> T.R Handle

gstdin pstdin p = T.uconstUse pstdin p sstdin

sstdin = T.uconstDef T.mkRoot astdin (\ p -> fromHandle p IO.stdin)

gstdout :: T.RefSrcPos -> T.RefExp -> T.R Handle

gstdout pstdout p = T.uconstUse pstdout p sstdout

sstdout = T.uconstDef T.mkRoot astdout (\ p -> fromHandle p IO.stdout)

gstderr :: T.RefSrcPos -> T.RefExp -> T.R Handle

gstderr pstderr p = T.uconstUse pstderr p sstderr

sstderr = T.uconstDef T.mkRoot astderr (\ p -> fromHandle p IO.stderr)

gopenFile ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun String (T.Fun IOMode (IO Handle)))

gopenFile popenFile p = T.ufun2 aopenFile popenFile p hopenFile

hopenFile z1openFile z2openFile kopenFile =
  (T.fromIO fromHandle) kopenFile
    (IO.openFile (toString kopenFile z1openFile)
      (toIOMode kopenFile z2openFile))

ghClose :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO T.Tuple0))

ghClose phClose p = T.ufun1 ahClose phClose p hhClose

hhClose z1hClose khClose =
  (T.fromIO T.fromTuple0) khClose (IO.hClose (toHandle khClose z1hClose))

ghFileSize :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Integer))

ghFileSize phFileSize p = T.ufun1 ahFileSize phFileSize p hhFileSize

hhFileSize z1hFileSize khFileSize =
  (T.fromIO T.fromInteger) khFileSize
    (IO.hFileSize (toHandle khFileSize z1hFileSize))

ghIsEOF :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Bool))

ghIsEOF phIsEOF p = T.ufun1 ahIsEOF phIsEOF p hhIsEOF

hhIsEOF z1hIsEOF khIsEOF =
  (T.fromIO fromBool) khIsEOF (IO.hIsEOF (toHandle khIsEOF z1hIsEOF))

gisEOF :: T.RefSrcPos -> T.RefExp -> T.R (IO Bool)

sisEOF :: T.R (IO Bool)

gisEOF pisEOF p = T.uconstUse pisEOF p sisEOF

sisEOF =
  T.uconstDef T.mkRoot aisEOF
    (\ p -> T.uwrapForward p (hhIsEOF (gstdin T.mkNoSrcPos p) p))

ghSetBuffering ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (T.Fun BufferMode (IO T.Tuple0)))

ghSetBuffering phSetBuffering p =
  T.ufun2 ahSetBuffering phSetBuffering p hhSetBuffering

hhSetBuffering z1hSetBuffering z2hSetBuffering khSetBuffering =
  (T.fromIO T.fromTuple0) khSetBuffering
    (IO.hSetBuffering (toHandle khSetBuffering z1hSetBuffering)
      (toBufferMode khSetBuffering z2hSetBuffering))

ghGetBuffering :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO BufferMode))

ghGetBuffering phGetBuffering p =
  T.ufun1 ahGetBuffering phGetBuffering p hhGetBuffering

hhGetBuffering z1hGetBuffering khGetBuffering =
  (T.fromIO fromBufferMode) khGetBuffering
    (IO.hGetBuffering (toHandle khGetBuffering z1hGetBuffering))

ghFlush :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO T.Tuple0))

ghFlush phFlush p = T.ufun1 ahFlush phFlush p hhFlush

hhFlush z1hFlush khFlush =
  (T.fromIO T.fromTuple0) khFlush (IO.hFlush (toHandle khFlush z1hFlush))

ghGetPosn :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO HandlePosn))

ghGetPosn phGetPosn p = T.ufun1 ahGetPosn phGetPosn p hhGetPosn

hhGetPosn z1hGetPosn khGetPosn =
  (T.fromIO fromHandlePosn) khGetPosn
    (IO.hGetPosn (toHandle khGetPosn z1hGetPosn))

ghSetPosn :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun HandlePosn (IO T.Tuple0))

ghSetPosn phSetPosn p = T.ufun1 ahSetPosn phSetPosn p hhSetPosn

hhSetPosn z1hSetPosn khSetPosn =
  (T.fromIO T.fromTuple0) khSetPosn
    (IO.hSetPosn (toHandlePosn khSetPosn z1hSetPosn))

ghSeek ::
  T.RefSrcPos ->
    T.RefExp ->
      T.R (T.Fun Handle (T.Fun SeekMode (T.Fun Integer (IO T.Tuple0))))

ghSeek phSeek p = T.ufun3 ahSeek phSeek p hhSeek

hhSeek z1hSeek z2hSeek z3hSeek khSeek =
  (T.fromIO T.fromTuple0) khSeek
    (IO.hSeek (toHandle khSeek z1hSeek) (toSeekMode khSeek z2hSeek)
      (T.toInteger khSeek z3hSeek))

ghWaitForInput ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (T.Fun Int (IO Bool)))

ghWaitForInput phWaitForInput p =
  T.ufun2 ahWaitForInput phWaitForInput p hhWaitForInput

hhWaitForInput z1hWaitForInput z2hWaitForInput khWaitForInput =
  (T.fromIO fromBool) khWaitForInput
    (IO.hWaitForInput (toHandle khWaitForInput z1hWaitForInput)
      (T.toInt khWaitForInput z2hWaitForInput))

ghReady :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Bool))

hhReady :: (T.R Handle) -> T.RefExp -> T.R (IO Bool)

ghReady phReady p = T.ufun1 ahReady phReady p hhReady

hhReady fh p =
  T.uwrapForward p
    (hhWaitForInput fh
      (T.uap1 T.mkNoSrcPos p (Hat.PreludeBasic.gfromInteger T.mkNoSrcPos p)
        (T.conInteger T.mkNoSrcPos p 0)) p)

ghGetChar :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Char))

ghGetChar phGetChar p = T.ufun1 ahGetChar phGetChar p hhGetChar

hhGetChar z1hGetChar khGetChar =
  (T.fromIO T.fromChar) khGetChar (IO.hGetChar (toHandle khGetChar z1hGetChar))

ghGetLine :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO String))

ghGetLine phGetLine p = T.ufun1 ahGetLine phGetLine p hhGetLine

hhGetLine z1hGetLine khGetLine =
  (T.fromIO fromString) khGetLine (IO.hGetLine (toHandle khGetLine z1hGetLine))

ghLookAhead :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Char))

ghLookAhead phLookAhead p = T.ufun1 ahLookAhead phLookAhead p hhLookAhead

hhLookAhead z1hLookAhead khLookAhead =
  (T.fromIO T.fromChar) khLookAhead
    (IO.hLookAhead (toHandle khLookAhead z1hLookAhead))

ghGetContents :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO String))

ghGetContents phGetContents p =
  T.ufun1 ahGetContents phGetContents p hhGetContents

hhGetContents z1hGetContents khGetContents =
  (T.fromIO fromString) khGetContents
    (IO.hGetContents (toHandle khGetContents z1hGetContents))

ghPutChar ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (T.Fun Char (IO T.Tuple0)))

ghPutChar phPutChar p = T.ufun2 ahPutChar phPutChar p hhPutChar

hhPutChar z1hPutChar z2hPutChar khPutChar =
  (T.fromIO T.fromTuple0) khPutChar
    ((\_ h c -> T.outputTrace khPutChar [c] Prelude.>> IO.hPutChar h c) Prelude.True
      (toHandle khPutChar z1hPutChar) (T.toChar khPutChar z2hPutChar))

ghPutStr ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (T.Fun String (IO T.Tuple0)))

ghPutStr phPutStr p = T.ufun2 ahPutStr phPutStr p hhPutStr

hhPutStr z1hPutStr z2hPutStr khPutStr =
  (T.fromIO T.fromTuple0) khPutStr
    ((\_ h s -> T.outputTrace khPutStr s Prelude.>> IO.hPutStr h s) Prelude.True
      (toHandle khPutStr z1hPutStr) (toString khPutStr z2hPutStr))

ghPutStrLn ::
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (T.Fun String (IO T.Tuple0)))

hhPutStrLn :: (T.R Handle) -> (T.R String) -> T.RefExp -> T.R (IO T.Tuple0)

ghPutStrLn phPutStrLn p = T.ufun2 ahPutStrLn phPutStrLn p hhPutStrLn

hhPutStrLn fh fs p =
  T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>> p)
    (T.uwrapForward p (hhPutStr fh fs p))
    (T.uwrapForward p (hhPutStr fh (T.fromLitString T.mkNoSrcPos p "\n") p))

ghPrint ::
  Show a =>
  T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (T.Fun a (IO T.Tuple0)))

hhPrint :: Show a => (T.R Handle) -> (T.R a) -> T.RefExp -> T.R (IO T.Tuple0)

ghPrint phPrint p = T.ufun2 ahPrint phPrint p hhPrint

hhPrint fh fx p =
  T.uwrapForward p
    (hhPutStrLn fh (T.uap1 T.mkNoSrcPos p (gshow T.mkNoSrcPos p) fx) p)

ghIsOpen :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Bool))

ghIsOpen phIsOpen p = T.ufun1 ahIsOpen phIsOpen p hhIsOpen

hhIsOpen z1hIsOpen khIsOpen =
  (T.fromIO fromBool) khIsOpen (IO.hIsOpen (toHandle khIsOpen z1hIsOpen))

ghIsClosed :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Bool))

ghIsClosed phIsClosed p = T.ufun1 ahIsClosed phIsClosed p hhIsClosed

hhIsClosed z1hIsClosed khIsClosed =
  (T.fromIO fromBool) khIsClosed
    (IO.hIsClosed (toHandle khIsClosed z1hIsClosed))

ghIsReadable :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Bool))

ghIsReadable phIsReadable p = T.ufun1 ahIsReadable phIsReadable p hhIsReadable

hhIsReadable z1hIsReadable khIsReadable =
  (T.fromIO fromBool) khIsReadable
    (IO.hIsReadable (toHandle khIsReadable z1hIsReadable))

ghIsWritable :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Bool))

ghIsWritable phIsWritable p = T.ufun1 ahIsWritable phIsWritable p hhIsWritable

hhIsWritable z1hIsWritable khIsWritable =
  (T.fromIO fromBool) khIsWritable
    (IO.hIsWritable (toHandle khIsWritable z1hIsWritable))

ghIsSeekable :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun Handle (IO Bool))

ghIsSeekable phIsSeekable p = T.ufun1 ahIsSeekable phIsSeekable p hhIsSeekable

hhIsSeekable z1hIsSeekable khIsSeekable =
  (T.fromIO fromBool) khIsSeekable
    (IO.hIsSeekable (toHandle khIsSeekable z1hIsSeekable))

gisAlreadyExistsError :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisAlreadyExistsError pisAlreadyExistsError p =
  T.ufun1 aisAlreadyExistsError pisAlreadyExistsError p hisAlreadyExistsError

hisAlreadyExistsError z1isAlreadyExistsError kisAlreadyExistsError =
  fromBool kisAlreadyExistsError
    (Error.isAlreadyExistsError
      (toIOError kisAlreadyExistsError z1isAlreadyExistsError))

gisDoesNotExistError :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisDoesNotExistError pisDoesNotExistError p =
  T.ufun1 aisDoesNotExistError pisDoesNotExistError p hisDoesNotExistError

hisDoesNotExistError z1isDoesNotExistError kisDoesNotExistError =
  fromBool kisDoesNotExistError
    (Error.isDoesNotExistError
      (toIOError kisDoesNotExistError z1isDoesNotExistError))

gisAlreadyInUseError :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisAlreadyInUseError pisAlreadyInUseError p =
  T.ufun1 aisAlreadyInUseError pisAlreadyInUseError p hisAlreadyInUseError

hisAlreadyInUseError z1isAlreadyInUseError kisAlreadyInUseError =
  fromBool kisAlreadyInUseError
    (Error.isAlreadyInUseError
      (toIOError kisAlreadyInUseError z1isAlreadyInUseError))

gisFullError :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisFullError pisFullError p = T.ufun1 aisFullError pisFullError p hisFullError

hisFullError z1isFullError kisFullError =
  fromBool kisFullError
    (Error.isFullError (toIOError kisFullError z1isFullError))

gisEOFError :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisEOFError pisEOFError p = T.ufun1 aisEOFError pisEOFError p hisEOFError

hisEOFError z1isEOFError kisEOFError =
  fromBool kisEOFError (Error.isEOFError (toIOError kisEOFError z1isEOFError))

gisIllegalOperation :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisIllegalOperation pisIllegalOperation p =
  T.ufun1 aisIllegalOperation pisIllegalOperation p hisIllegalOperation

hisIllegalOperation z1isIllegalOperation kisIllegalOperation =
  fromBool kisIllegalOperation
    (Error.isIllegalOperation
      (toIOError kisIllegalOperation z1isIllegalOperation))

gisPermissionError :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisPermissionError pisPermissionError p =
  T.ufun1 aisPermissionError pisPermissionError p hisPermissionError

hisPermissionError z1isPermissionError kisPermissionError =
  fromBool kisPermissionError
    (Error.isPermissionError (toIOError kisPermissionError z1isPermissionError))

gisUserError :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError Bool)

gisUserError pisUserError p = T.ufun1 aisUserError pisUserError p hisUserError

hisUserError z1isUserError kisUserError =
  fromBool kisUserError
    (Error.isUserError (toIOError kisUserError z1isUserError))

gioeGetErrorString :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError String)

gioeGetErrorString pioeGetErrorString p =
  T.ufun1 aioeGetErrorString pioeGetErrorString p hioeGetErrorString

hioeGetErrorString z1ioeGetErrorString kioeGetErrorString =
  fromString kioeGetErrorString
    (Error.ioeGetErrorString (toIOError kioeGetErrorString z1ioeGetErrorString))

gioeGetHandle :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError (Maybe Handle))

gioeGetHandle pioeGetHandle p =
  T.ufun1 aioeGetHandle pioeGetHandle p hioeGetHandle

hioeGetHandle z1ioeGetHandle kioeGetHandle =
  (fromMaybe fromHandle) kioeGetHandle
    (Error.ioeGetHandle (toIOError kioeGetHandle z1ioeGetHandle))

gioeGetFileName :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun IOError (Maybe String))

gioeGetFileName pioeGetFileName p =
  T.ufun1 aioeGetFileName pioeGetFileName p hioeGetFileName

hioeGetFileName z1ioeGetFileName kioeGetFileName =
  (fromMaybe fromString) kioeGetFileName
    (Error.ioeGetFileName (toIOError kioeGetFileName z1ioeGetFileName))

gtry :: T.RefSrcPos -> T.RefExp -> T.R (T.Fun (IO a) (IO (Either IOError a)))

htry :: (T.R (IO a)) -> T.RefExp -> T.R (IO (Either IOError a))

gtry ptry p = T.ufun1 atry ptry p htry

htry ff p =
  T.uwrapForward p
    (hcatch
      (T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>>= p) ff
        (T.ufun1 T.mkDoLambda T.mkNoSrcPos p
          (\ fr p ->
            T.uap1 T.mkNoSrcPos p (greturn T.mkNoSrcPos p)
              (T.con1 T.mkNoSrcPos p Right aRight fr))))
      (T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos !. p) (greturn T.mkNoSrcPos p)
        (T.pa0 Left T.cn1 T.mkNoSrcPos p aLeft)) p)

gbracket ::
  T.RefSrcPos ->
    T.RefExp ->
      T.R
        (T.Fun (IO a) (T.Fun (T.Fun a (IO b)) (T.Fun (T.Fun a (IO c)) (IO c))))

hbracket ::
  (T.R (IO a)) ->
    (T.R (T.Fun a (IO b))) -> (T.R (T.Fun a (IO c))) -> T.RefExp -> T.R (IO c)

gbracket pbracket p = T.ufun3 abracket pbracket p hbracket

hbracket fbefore fafter fm p =
  T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>>= p) fbefore
    (T.ufun1 T.mkDoLambda T.mkNoSrcPos p
      (\ fx p ->
        T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>>= p)
          (T.uwrapForward p (htry (T.uap1 T.mkNoSrcPos p fm fx) p))
          (T.ufun1 T.mkDoLambda T.mkNoSrcPos p
            (\ frs p ->
              T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>> p)
                (T.uap1 T.mkNoSrcPos p fafter fx)
                (T.uccase T.mkNoSrcPos p
                  (let
                    v173v9v175v31v1 (T.R (Right fr) _) p =
                      T.uap1 T.mkNoSrcPos p (greturn T.mkNoSrcPos p) fr
                    v173v9v175v31v1 (T.R (Left fe) _) p =
                      T.uwrapForward p (hioError fe p)
                    v173v9v175v31v1 _ p = T.fatal p in (v173v9v175v31v1))
                  frs)))))

gbracket_ ::
  T.RefSrcPos ->
    T.RefExp ->
      T.R (T.Fun (IO a) (T.Fun (T.Fun a (IO b)) (T.Fun (IO c) (IO c))))

hbracket_ ::
  (T.R (IO a)) ->
    (T.R (T.Fun a (IO b))) -> (T.R (IO c)) -> T.RefExp -> T.R (IO c)

gbracket_ pbracket_ p = T.ufun3 abracket_ pbracket_ p hbracket_

hbracket_ fbefore fafter fm p =
  T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>>= p) fbefore
    (T.ufun1 T.mkDoLambda T.mkNoSrcPos p
      (\ fx p ->
        T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>>= p)
          (T.uwrapForward p (htry fm p))
          (T.ufun1 T.mkDoLambda T.mkNoSrcPos p
            (\ frs p ->
              T.uap2 T.mkNoSrcPos p (T.mkNoSrcPos Hat.Prelude.!>> p)
                (T.uap1 T.mkNoSrcPos p fafter fx)
                (T.uccase T.mkNoSrcPos p
                  (let
                    v183v10v185v32v1 (T.R (Right fr) _) p =
                      T.uap1 T.mkNoSrcPos p (greturn T.mkNoSrcPos p) fr
                    v183v10v185v32v1 (T.R (Left fe) _) p =
                      T.uwrapForward p (hioError fe p)
                    v183v10v185v32v1 _ p = T.fatal p in (v183v10v185v32v1))
                  frs)))))

tIO = T.mkModule "IO" "IO.hs" Prelude.False

aprimHandleEq = T.mkVariable tIO 360001 370041 3 2 "primHandleEq" Prelude.False

aprimHandleShowsPrec =
  T.mkVariable tIO 390001 400057 3 3 "primHandleShowsPrec" Prelude.False

aprimHandlePosnEq =
  T.mkVariable tIO 500001 510053 3 2 "primHandlePosnEq" Prelude.False

astdin = T.mkVariable tIO 650001 660016 3 0 "stdin" Prelude.False

astdout = T.mkVariable tIO 670001 680017 3 0 "stdout" Prelude.False

astderr = T.mkVariable tIO 690001 700017 3 0 "stderr" Prelude.False

aopenFile = T.mkVariable tIO 720001 730048 3 2 "openFile" Prelude.False

ahClose = T.mkVariable tIO 740001 750038 3 1 "hClose" Prelude.False

ahFileSize = T.mkVariable tIO 770001 780038 3 1 "hFileSize" Prelude.False

ahIsEOF = T.mkVariable tIO 790001 800038 3 1 "hIsEOF" Prelude.False

aisEOF = T.mkVariable tIO 830001 830037 3 0 "isEOF" Prelude.False

ahSetBuffering =
  T.mkVariable tIO 850001 860053 3 2 "hSetBuffering" Prelude.False

ahGetBuffering =
  T.mkVariable tIO 870001 880039 3 1 "hGetBuffering" Prelude.False

ahFlush = T.mkVariable tIO 890001 900038 3 1 "hFlush" Prelude.False

ahGetPosn = T.mkVariable tIO 910001 920038 3 1 "hGetPosn" Prelude.False

ahSetPosn = T.mkVariable tIO 930001 940042 3 1 "hSetPosn" Prelude.False

ahSeek = T.mkVariable tIO 950001 960061 3 3 "hSeek" Prelude.False

ahWaitForInput =
  T.mkVariable tIO 980001 990043 3 2 "hWaitForInput" Prelude.False

ahReady = T.mkVariable tIO 1020001 1020028 3 1 "hReady" Prelude.False

ahGetChar = T.mkVariable tIO 1040001 1050038 3 1 "hGetChar" Prelude.False

ahGetLine = T.mkVariable tIO 1060001 1070038 3 1 "hGetLine" Prelude.False

ahLookAhead = T.mkVariable tIO 1080001 1090038 3 1 "hLookAhead" Prelude.False

ahGetContents =
  T.mkVariable tIO 1100001 1110038 3 1 "hGetContents" Prelude.False

ahPutChar = T.mkVariable tIO 1120001 1130046 3 2 "hPutChar" Prelude.False

ahPutStr = T.mkVariable tIO 1140001 1150048 3 2 "hPutStr" Prelude.False

ahPutStrLn = T.mkVariable tIO 1180001 1190038 3 2 "hPutStrLn" Prelude.False

ahPrint = T.mkVariable tIO 1220001 1220032 3 2 "hPrint" Prelude.False

ahIsOpen = T.mkVariable tIO 1240001 1250038 3 1 "hIsOpen" Prelude.False

ahIsClosed = T.mkVariable tIO 1260001 1270038 3 1 "hIsClosed" Prelude.False

ahIsReadable = T.mkVariable tIO 1280001 1290038 3 1 "hIsReadable" Prelude.False

ahIsWritable = T.mkVariable tIO 1300001 1310038 3 1 "hIsWritable" Prelude.False

ahIsSeekable = T.mkVariable tIO 1320001 1330038 3 1 "hIsSeekable" Prelude.False

aisAlreadyExistsError =
  T.mkVariable tIO 1350001 1360041 3 1 "isAlreadyExistsError" Prelude.False

aisDoesNotExistError =
  T.mkVariable tIO 1370001 1380041 3 1 "isDoesNotExistError" Prelude.False

aisAlreadyInUseError =
  T.mkVariable tIO 1390001 1400041 3 1 "isAlreadyInUseError" Prelude.False

aisFullError = T.mkVariable tIO 1410001 1420041 3 1 "isFullError" Prelude.False

aisEOFError = T.mkVariable tIO 1430001 1440041 3 1 "isEOFError" Prelude.False

aisIllegalOperation =
  T.mkVariable tIO 1450001 1460041 3 1 "isIllegalOperation" Prelude.False

aisPermissionError =
  T.mkVariable tIO 1470001 1480041 3 1 "isPermissionError" Prelude.False

aisUserError = T.mkVariable tIO 1490001 1500041 3 1 "isUserError" Prelude.False

aioeGetErrorString =
  T.mkVariable tIO 1520001 1530043 3 1 "ioeGetErrorString" Prelude.False

aioeGetHandle =
  T.mkVariable tIO 1540001 1550042 3 1 "ioeGetHandle" Prelude.False

aioeGetFileName =
  T.mkVariable tIO 1570001 1580042 3 1 "ioeGetFileName" Prelude.False

atry = T.mkVariable tIO 1640001 1660038 3 1 "try" Prelude.False

abracket = T.mkVariable tIO 1690001 1750031 3 3 "bracket" Prelude.False

abracket_ = T.mkVariable tIO 1790001 1850032 3 3 "bracket_" Prelude.False

(+&%=&=&%=$#==) = T.mkVariable tIO 430004 430021 16 0 "==" Prelude.False

a46v3v46v33showsPrec =
  T.mkVariable tIO 460003 460033 3 0 "showsPrec" Prelude.False

(+*&=&=*&=$*==) = T.mkVariable tIO 540004 540025 16 0 "==" Prelude.False
