// ==============================================================================
//
// 描述： 匿名函数转方法指针
// 作者： 牧马人
//
// Description： Convert Method Reference to Method Pointer
// Author： Chang
//
// Usage：TAnonymousEvent.Create<MethodReferenceType，MethodPointerType>;
// For TNotifyEvent，you can use :
// Button1.OnClick :=  TAnonymousEvent.Create(
// procedure(Sender:TObject)
// begin
//
// end
// );
// ==============================================================================

unit AnonymousEvent;

interface

uses System.SysUtils, System.Classes, System.Rtti;

type
  TAnonymousEvent = record
  strict private
    // 真正执行转换的方法
    class procedure MethodReferenceToMethodPointer(const MethodReference;
      var MethodPointer); static; inline;
  public
    class function Create<MethodRefType, ResultType>(const MethodRef
      : MethodRefType): ResultType; overload; static; inline;
    class function Create(const NotifyEvent: TProc<TObject>): TNotifyEvent;
      overload; static; inline;
    // Create a TNotifyEvent and wrap it in TValue
    class function CreateAsTValue(const NotifyEvent: TProc<TObject>): TValue;
      static; inline;
  end;

implementation

{ TAnonymousEvent }

class function TAnonymousEvent.Create(const NotifyEvent: TProc<TObject>)
  : TNotifyEvent;
begin
  Result := TAnonymousEvent.Create<TProc<TObject>, TNotifyEvent>(NotifyEvent);
end;

class function TAnonymousEvent.Create<MethodRefType, ResultType>(const MethodRef
  : MethodRefType): ResultType;
begin
  MethodReferenceToMethodPointer(MethodRef, Result);
end;

class function TAnonymousEvent.CreateAsTValue(const NotifyEvent
  : TProc<TObject>): TValue;
begin
  Result := TValue.From<TNotifyEvent>(Create(NotifyEvent));
end;

class procedure TAnonymousEvent.MethodReferenceToMethodPointer
  (const MethodReference; var MethodPointer);
begin
  with TMethod(MethodPointer) do
  begin
    Code := PPointer(IntPtr(PPointer(MethodReference)^) + SizeOf(Pointer) * 3)^;
    Data := Pointer(MethodReference);
  end;
end;

end.
